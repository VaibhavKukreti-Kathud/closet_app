import 'dart:io';
import 'dart:ui';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:animations/animations.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:closet_app/app.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart' as s;
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:closet_app/ui/screens/navigation/add_post/add_product_screen.dart';
import 'package:closet_app/ui/screens/chat/chats_screen.dart';
import 'package:closet_app/ui/screens/navigation/groups/create_group_screen.dart';
import 'package:closet_app/ui/screens/navigation/discover/discover_screen.dart';
import 'package:closet_app/ui/screens/navigation/favorites/favorite_screen.dart';
import 'package:closet_app/ui/screens/navigation/groups/group_home_screen.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/mycloset_screen.dart';
import 'package:closet_app/ui/screens/social/followers_screen.dart';
import 'package:closet_app/ui/screens/social/following_screen.dart';
import 'package:flutter/cupertino.dart';
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
  static const double? _iconSize = 20;

  get kBottomNavbarHeight => 58;
  late NotchBottomBarController notchBottomBarController;

  @override
  void initState() {
    super.initState();
    notchBottomBarController = NotchBottomBarController();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DiscoverScreen(),
      const GroupsListScreen(),
      const AddProductScreen(),
      const FavoriteScreen(),
      const MyClosetScreen(),
    ];

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
      extendBodyBehindAppBar: true,
      extendBody: true,
      // bottomNavigationBar: Skeletonizer(
      //   enabled: !loggedin,
      //   child: Container(
      //     height: Platform.isIOS ? 84 : kBottomNavbarHeight,
      //     padding: Platform.isIOS
      //         ? EdgeInsets.only(
      //             left: MediaQuery.of(context).size.width / 7.7,
      //             right: MediaQuery.of(context).size.width / 7.7,
      //             bottom: 20)
      //         : EdgeInsets.symmetric(
      //             horizontal: MediaQuery.of(context).size.width / 7.2),
      //     decoration: BoxDecoration(
      //       boxShadow: [s.kSubtleShadow],
      //       border: Border(top: BorderSide.none),
      //       color: Theme.of(context).scaffoldBackgroundColor,
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap: () => setState(() {
      //             reverse = false;
      //             _selectedIndex = 0;
      //           }),
      //           child: Icon(
      //             Iconsax.discover,
      //             size: _iconSize,
      //             color: _selectedIndex == 0 ? selectedColor : unselectedColor,
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () => setState(() {
      //             reverse = _selectedIndex < 1 ? true : false;
      //             _selectedIndex = 1;
      //           }),
      //           child: Icon(
      //             Iconsax.messages,
      //             size: _iconSize,
      //             color: _selectedIndex == 1 ? selectedColor : unselectedColor,
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () => setState(() {
      //             reverse = _selectedIndex < 2 ? true : false;
      //             _selectedIndex = 2;
      //           }),
      //           child: Icon(
      //             Iconsax.heart,
      //             size: _iconSize,
      //             color: _selectedIndex == 2 ? selectedColor : unselectedColor,
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () => setState(() {
      //             reverse = _selectedIndex < 3 ? true : false;
      //             _selectedIndex = 3;
      //           }),
      //           child: Icon(
      //             Iconsax.profile_circle,
      //             size: _iconSize,
      //             color: _selectedIndex == 3 ? selectedColor : unselectedColor,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Stack(
          children: [
            Positioned(
              left: 24,
              right: 24,
              top: 21.9,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.8),
                        boxShadow: []),
                  ),
                ),
              ),
            ),
            AnimatedNotchBottomBar(
              notchBottomBarController: notchBottomBarController,
              bottomBarItems: const <BottomBarItem>[
                BottomBarItem(
                  inActiveItem: Icon(
                    Iconsax.discover,
                    size: _iconSize,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Iconsax.discover,
                    size: _iconSize,
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Iconsax.profile_2user,
                    size: _iconSize,
                    color: Colors.black,
                  ),
                  activeItem: Icon(Iconsax.profile_2user,
                      size: _iconSize, color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Iconsax.add,
                    size: _iconSize,
                    color: Colors.black,
                  ),
                  activeItem:
                      Icon(Iconsax.add, size: _iconSize, color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bookmark_outline,
                    size: _iconSize,
                    color: Colors.black,
                  ),
                  activeItem: Icon(Icons.bookmark_outline,
                      size: _iconSize, color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Iconsax.profile_circle,
                    size: _iconSize,
                    color: Colors.black,
                  ),
                  activeItem: Icon(Iconsax.profile_circle,
                      size: _iconSize, color: Colors.white),
                ),
              ],
              onTap: (index) {
                setState(() {
                  reverse = _selectedIndex < index;
                  _selectedIndex = index;
                });
              },
              kIconSize: _iconSize ?? 25,
              kBottomRadius: 30,
              shadowElevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              notchColor: Colors.black,
            ),
          ],
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
              child: pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupsListScreen extends StatefulWidget {
  const GroupsListScreen({
    super.key,
  });

  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Groups"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateGroupScreen()));
                },
                padding: EdgeInsets.zero,
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.add_square, size: 20),
                      SizedBox(width: 6),
                      Text('New'),
                    ],
                  ),
                )),
          ],
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: CustomSearchField(
                      controller: controller,
                      hintText: 'Search',
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    tileColor: Color(0xffEDCEBC),
                    minVerticalPadding: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),
                    title: Text("Group $index"),
                    trailing: AvatarStack(
                        width: 56,
                        height: 20,
                        borderColor: Color(0xffEDCEBC),
                        avatars: [
                          NetworkImage("https://picsum.photos/200"),
                          NetworkImage("https://picsum.photos/200"),
                          NetworkImage("https://picsum.photos/200"),
                          NetworkImage("https://picsum.photos/200"),
                        ]),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return GroupHomeScreen();
                      }));
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}

class CustomSearchField extends StatefulWidget {
  CustomSearchField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.obscured = false,
    this.onTap,
    this.onEdit,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscured;
  final String hintText;
  final FocusNode? focusNode;
  var onTap;
  var onEdit;
  Icon? prefixIcon;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    bool showing = widget.obscured;

    var kBorderRadius2 = 10.0;
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 182, 182, 182), width: 1),
          color: kBGFieldColor,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            color: Colors.grey.shade600,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              focusNode: widget.focusNode,
              controller: widget.controller,
              obscureText: showing,
              onChanged: widget.onEdit,
              onTap: widget.onTap,
              decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
                  hintText: widget.hintText,

                  // fillColor: Colors.red,
                  // filled: true,
                  hintStyle: TextStyle(
                      fontSize: 17, color: Colors.black.withOpacity(0.35)),
                  contentPadding: EdgeInsets.symmetric(),
                  border: InputBorder.none),
            ),
          ),
          widget.obscured
              ? SizedBox(
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showing = !showing;
                      });
                    },
                    icon: Icon(
                      !showing
                          ? Icons.visibility_off_rounded
                          : Icons.visibility,
                      color: Colors.black54,
                      size: 17,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
