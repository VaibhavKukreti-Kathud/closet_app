import 'package:closet_app/constants.dart';
import 'package:closet_app/models/post_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/auth/auth_functions.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:closet_app/ui/screens/navigation/search/search_screen.dart';
import 'package:closet_app/ui/screens/social/followers_screen.dart';
import 'package:closet_app/ui/screens/social/following_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../stories_screen.dart';
import 'package:flutter/cupertino.dart';
import '../widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        centerTitle: false,
        title: InkWell(
          onTap: () {
            context.read<AuthFunctions>().signOut();
          },
          child:
              SvgPicture.asset('assets/logo_peach.svg', width: 100, height: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(Iconsax.search_normal),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.message),
          ),
        ],
      ),

      // drawer: Drawer(
      //   backgroundColor: currTheme.scaffoldBackgroundColor,
      //   child: ListView(
      //     shrinkWrap: true,
      //     children: [
      //       ListTile(
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
      //         ),
      //         title: Text(
      //           'vklightning',
      //           style: TextStyle(
      //               fontSize: 24.0,
      //               color: currTheme.textTheme.bodyMedium!.color),
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => FollowersScreen()));
      //         },
      //         child: ListTile(
      //           title: Text(
      //             'Followers',
      //             style:
      //                 TextStyle(color: currTheme.textTheme.bodyMedium!.color),
      //           ),
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => FollowingScreen()));
      //         },
      //         child: ListTile(
      //           title: Text(
      //             'Following',
      //             style:
      //                 TextStyle(color: currTheme.textTheme.bodyMedium!.color),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('postedAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: SizedBox.shrink());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, i) {
                  final post = Post.fromMap(
                      snapshot.data!.docs[i].data() as Map<String, dynamic>);
                  return Column(
                    children: [
                      i == 0
                          ? Column(
                              children: [
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Chip(
                                      label: Text('All'),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Chip(
                                      label: Text('Male'),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Chip(
                                      label: Text('Female'),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Chip(
                                      label: Icon(Icons.menu_book_rounded),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                  ],
                                ),
                                SizedBox(height: 12),
                              ],
                            )
                          : SizedBox(),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          child: PostWidget(
                            post: post,
                          )),
                    ],
                  );
                }),
              );
            }
          }),
    );
  }
}
