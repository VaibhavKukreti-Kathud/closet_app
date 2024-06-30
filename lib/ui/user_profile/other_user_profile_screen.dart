import 'dart:async';

import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({super.key, required this.user});

  final AppUser user;

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  bool? alreadyFollowing;
  int followers = 0;
  int following = 0;

  showPostsChecker() {
    if (!(alreadyFollowing ?? false)) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Icon(
              Icons.lock,
              size: 100,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                'This person has locked their posts.\nFollow them to see their posts.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                )),
          ],
        ),
      );
    } else {
      return GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 30),
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(13, (index) {
          return Image.network("https://picsum.photos/300");
        }),
      );
    }
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        FirebaseFirestore.instance
            .collection(FirestoreConstants.USER_COLLECTION)
            .doc(user.uid)
            .collection('followers')
            .doc(widget.user.id)
            .get()
            .then((value) {
          if (value.exists) {
            setState(() {
              alreadyFollowing = true;
            });
          } else {
            setState(() {
              alreadyFollowing = false;
            });
          }
        });
      }
    });

    fetchFollowersCount();
    fetchFollowingCount();
    super.initState();
  }

  void fetchFollowingCount() {
    FirebaseFirestore.instance
        .collection(FirestoreConstants.USER_COLLECTION)
        .doc(widget.user.id)
        .collection('following')
        .get()
        .then((value) {
      setState(() {
        following = value.docs.length;
      });
    });
  }

  void fetchFollowersCount() {
    FirebaseFirestore.instance
        .collection(FirestoreConstants.USER_COLLECTION)
        .doc(widget.user.id)
        .collection('followers')
        .get()
        .then((value) {
      setState(() {
        followers = value.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User\'s Profile'),
      ),
      body: ListView(
        children: [
          _buildHeaderProfileInfo(context),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  offset: const Offset(0, 3),
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirestoreConstants.USER_COLLECTION)
                        .doc(widget.user.id)
                        .collection('followers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('');
                      }
                      return _buildStatsTile(
                        snapshot.data!.docs.length.toString(),
                        'Followers',
                      );
                    }),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade200,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirestoreConstants.USER_COLLECTION)
                        .doc(widget.user.id)
                        .collection('following')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('');
                      }
                      return _buildStatsTile(
                        '0',
                        'Following',
                      );
                    }),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade200,
                ),
                _buildStatsTile('13', 'Posts'),
              ],
            ),
          ),
          showPostsChecker()
        ],
      ),
    );
  }

  Widget _buildStatsTile(String value, String title) {
    return Column(
      children: [
        Text(
          value,
        ),
        Text(
          title,
        )
      ],
    );
  }

  Widget _buildHeaderProfileInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.width * 2 / 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  widget.user.pfpUrl ?? 'https://picsum.photos/120'),
              radius: 53,
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.fullName,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal)),
                Text(widget.user.email,
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(height: 8),
                ZoomTapAnimation(
                  onTap: () {
                    if (alreadyFollowing == null) return;
                    if (alreadyFollowing!) {
                      FirebaseFirestore.instance
                          .collection(FirestoreConstants.USER_COLLECTION)
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('followers')
                          .doc(widget.user.id)
                          .delete();
                      FirebaseFirestore.instance
                          .collection(FirestoreConstants.USER_COLLECTION)
                          .doc(widget.user.id)
                          .collection('following')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .delete();
                    } else {
                      FirebaseFirestore.instance
                          .collection(FirestoreConstants.USER_COLLECTION)
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('followers')
                          .doc(widget.user.id)
                          .set({});
                      FirebaseFirestore.instance
                          .collection(FirestoreConstants.USER_COLLECTION)
                          .doc(widget.user.id)
                          .collection('following')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({});
                    }
                    setState(() {
                      alreadyFollowing = !alreadyFollowing!;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ((alreadyFollowing == null) || (alreadyFollowing!))
                          ? kSecondaryColor.withOpacity(0.3)
                          : kSecondaryColor,
                    ),
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10),
                    child: Center(
                      child: alreadyFollowing == null
                          ? CupertinoActivityIndicator()
                          : Text(
                              alreadyFollowing! ? "Unfollow" : "Follow",
                              style: TextStyle(
                                color: ((alreadyFollowing == null) ||
                                        (alreadyFollowing!))
                                    ? Colors.grey.shade900.withOpacity(0.2)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
