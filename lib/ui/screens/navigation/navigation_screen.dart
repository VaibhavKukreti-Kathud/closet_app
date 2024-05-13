import 'dart:io';
import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart' as s;
import 'package:closet_app/ui/screens/navigation/chat/chats_screen.dart';
import 'package:closet_app/ui/screens/navigation/discover/discover_screen.dart';
import 'package:closet_app/ui/screens/navigation/favorites/favorite_screen.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/mycloset_screen.dart';
import 'package:closet_app/ui/screens/social/followers_screen.dart';
import 'package:closet_app/ui/screens/social/following_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/style_constants.dart';

final GlobalKey<ScaffoldState> navScaffoldKey = GlobalKey<ScaffoldState>();

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  bool reverse = false;
  static const double _iconSize = 27.0;

  get kBottomNavbarHeight => 58;

  @override
  Widget build(BuildContext context) {
    bool loggedin = context.watch<UserProvider>().appUser != null;
    final List<Widget> _pages = [
      DiscoverScreen(),
      ChatsScreen(),
      FavoriteScreen(),
      MyClosetScreen(),
    ];
    final Color selectedColor = kButtonShadowColor.withOpacity(0.8);
    final Color unselectedColor = kDisabledColor.withOpacity(0.9);

    return Scaffold(
      key: navScaffoldKey,
      drawerScrimColor: Colors.white.withOpacity(0.8),
      drawer: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 7.0),
        duration: const Duration(milliseconds: 250),
        builder: (_, value, child) {
          //TODO: also need to animate the drawer dismiss blur value
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 48,
              offset: const Offset(20, 0),
              spreadRadius: -5,
              color: Colors.black.withOpacity(0.1),
            ),
          ]),
          child: Drawer(
            shadowColor: Colors.transparent,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.94),
            surfaceTintColor: Colors.transparent,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Hi Vaibhav!"),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Iconsax.user),
                    title: Text('Followers'),
                    onTap: () {
                      navScaffoldKey.currentState!.closeDrawer();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FollowersScreen();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Iconsax.tag_user),
                    title: Text('Following'),
                    onTap: () {
                      navScaffoldKey.currentState!.closeDrawer();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FollowingScreen();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Iconsax.presention_chart),
                    title: Text('Suggested'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Skeletonizer(
        enabled: !loggedin,
        child: Container(
          height: Platform.isIOS ? 84 : kBottomNavbarHeight,
          padding: Platform.isIOS
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 7.7,
                  right: MediaQuery.of(context).size.width / 7.7,
                  bottom: 20)
              : EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 7.2),
          decoration: BoxDecoration(
            boxShadow: [s.kSubtleShadow],
            border: Border(top: BorderSide.none),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  reverse = false;
                  _selectedIndex = 0;
                }),
                child: Icon(
                  Iconsax.discover,
                  size: _iconSize,
                  color: _selectedIndex == 0 ? selectedColor : unselectedColor,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  reverse = _selectedIndex < 1 ? true : false;
                  _selectedIndex = 1;
                }),
                child: Icon(
                  Iconsax.messages,
                  size: _iconSize,
                  color: _selectedIndex == 1 ? selectedColor : unselectedColor,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  reverse = _selectedIndex < 2 ? true : false;
                  _selectedIndex = 2;
                }),
                child: Icon(
                  Iconsax.heart,
                  size: _iconSize,
                  color: _selectedIndex == 2 ? selectedColor : unselectedColor,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  reverse = _selectedIndex < 3 ? true : false;
                  _selectedIndex = 3;
                }),
                child: Icon(
                  Iconsax.profile_circle,
                  size: _iconSize,
                  color: _selectedIndex == 3 ? selectedColor : unselectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageTransitionSwitcher(
            reverse: !reverse,
            transitionBuilder: (Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) {
              return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                child: child,
              );
            },
            child: Container(
              key: ValueKey(_selectedIndex),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
