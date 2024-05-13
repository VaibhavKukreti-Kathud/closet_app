import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({super.key, required this.user});

  final AppUser user;

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  late bool alreadyFollowing;
  showPostsChecker() {
    if (!alreadyFollowing) {
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
      return Expanded(
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 30),
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(13, (index) {
            return Image.network("https://picsum.photos/300");
          }),
        ),
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
    super.initState();
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
          SizedBox(height: 16.0),
          _buildHeaderProfileInfo(context),
          showPostsChecker()
        ],
      ),
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
              backgroundImage: NetworkImage("https://picsum.photos/300"),
              radius: 70,
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vaibhav Kukreti',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal)),
                Text(context.read<UserProvider>().appUser!.email,
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '100',
                        ),
                        Text(
                          'Followers',
                        )
                      ],
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Column(
                      children: [
                        Text(
                          '80',
                        ),
                        Text(
                          'Following',
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                ZoomTapAnimation(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10),
                    child: Center(
                      child: Text(
                        alreadyFollowing ? "Unfollow" : "Follow",
                        style: TextStyle(
                          color: Colors.white,
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
