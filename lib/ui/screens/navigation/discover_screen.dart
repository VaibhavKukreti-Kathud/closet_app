import 'package:closet_app/constants.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/auth/auth_functions.dart';
import 'package:closet_app/ui/screens/search/search_screen.dart';
import 'package:closet_app/ui/screens/social/followers_screen.dart';
import 'package:closet_app/ui/screens/social/following_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'stories_screen.dart';
import 'package:flutter/cupertino.dart';
import 'widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  ScrollController _OOTDController = ScrollController();

  bool shouldShowOOTD = true;

  @override
  void initState() {
    _OOTDController.addListener(() {
      if (_OOTDController.position.activity!.isScrolling) {
        setState(() {
          shouldShowOOTD = false;
        });
      }
      if (_OOTDController.position.atEdge) {
        bool atTop = _OOTDController.position.pixels == 0;
        if (atTop) {
          setState(() {
            shouldShowOOTD = true;
          });
        } else {}
      }
    });
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
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Iconsax.search_normal),
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: currTheme.scaffoldBackgroundColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
              ),
              title: Text(
                'vklightning',
                style: TextStyle(
                    fontSize: 24.0,
                    color: currTheme.textTheme.bodyMedium!.color),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FollowersScreen()));
              },
              child: ListTile(
                title: Text(
                  'Followers',
                  style:
                      TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FollowingScreen()));
              },
              child: ListTile(
                title: Text(
                  'Following',
                  style:
                      TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _OOTDController,
              children: [
                for (int i = 0; i < 10; i++)
                  Column(
                    children: [
                      i == 0
                          ? ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoriesScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    // color: Colors.grey.shade200,

                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        kSecondaryColor,
                                        kDisabledColor,
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Outfit of the day',
                                      style: TextStyle(
                                          fontSize: 28.0,
                                          fontFamily: 'Philosopher',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: PostWidget(
                            username: "username",
                            profilePictureUrl: "https://picsum.photos/80",
                            imageUrl: "https://picsum.photos/400",
                            caption: "Caught in 8k",
                            likes: 12,
                            comments: 11),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
