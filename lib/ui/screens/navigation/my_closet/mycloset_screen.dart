import 'dart:math';
import 'dart:ui';

import 'package:closet_app/models/wardrobe_category_model.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/categories_grid.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/posts_list.dart';
import 'package:closet_app/ui/screens/navigation/profile_settings_screen.dart';
import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyClosetScreen extends StatefulWidget {
  const MyClosetScreen({super.key});

  static List<WardrobeCategory> categories = [
    WardrobeCategory(
        name: "Tops",
        image:
            "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Bottoms",
        image:
            "https://images.unsplash.com/photo-1634564235572-cd6f37694266?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Footwear",
        image:
            "https://images.unsplash.com/flagged/photo-1556637640-2c80d3201be8?q=80&w=300&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Accessories",
        image:
            "https://images.unsplash.com/photo-1585856331426-d7a22437d4bb?q=80&w=300&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Outerwear",
        image:
            "https://images.unsplash.com/photo-1533230464445-e01ef07c65c5?q=80&w=300&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Jumpsuits",
        image:
            "https://images.unsplash.com/photo-1600689482725-bc3f308be252?q=80&w=300&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    WardrobeCategory(
        name: "Others",
        image:
            "https://images.unsplash.com/photo-1627511306341-f9d96646b91d?q=80&w=300&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];

  @override
  State<MyClosetScreen> createState() => _MyClosetScreenState();
}

class _MyClosetScreenState extends State<MyClosetScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  ValueNotifier<int> _currentScreen = ValueNotifier<int>(0);
  int _previousScreen = 0;

  _returnTab(int screen) {
    switch (screen) {
      case 1:
        return CategoriesGrid(
          key: ValueKey<int>(1),
        );
      case 0:
        return MyPostsList(
          key: ValueKey<int>(0),
        );
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 40,
        toolbarHeight: 86,
        centerTitle: false,
        title: 'My Closet',
        actionIcon: Icons.settings,
        onActionPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettingsScreen()));
        },
      ),
      body: ListView(
        children: [
          _buildHeaderProfileInfo(context),
          SizedBox(height: 4),
          TabBar(
              onTap: (value) {
                _previousScreen = _currentScreen.value;
                _currentScreen.value = value;
              },
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ))),
              tabs: [
                Tab(
                  text: "Posts",
                ),
                Tab(
                  text: "Categories",
                ),
              ],
              controller: tabController),
          // SizedBox(height: 100,
          //   child: TabBarView(
          //     controller: tabController,

          //     children: [
          //
          //       Container(),
          //     ],
          //   ),
          // ),

          ValueListenableBuilder<int>(
              valueListenable: _currentScreen,
              builder: (context, screen, child) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 50),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final inAnimation =
                        Tween<double>(begin: 0, end: 1).animate(animation);
                    final outAnimation =
                        Tween<double>(begin: 0, end: 1).animate(animation);

                    final Widget inTransition = ClipRect(
                      child: FadeTransition(
                        opacity: inAnimation,
                        child: child,
                      ),
                    );

                    final Widget outTransition = ClipRect(
                      child: FadeTransition(
                        opacity: outAnimation,
                        child: child,
                      ),
                    );

                    //// Transition for two screens
                    //                    if (child.key == ValueKey<int>(1)) {
                    //                      print(_previousScreen);
                    ////                    if (_previousScreen < screen) {
                    //                      return ClipRect(
                    //                        child: SlideTransition(
                    //                          position: inAnimation,
                    //                          child: Padding(
                    //                            padding: const EdgeInsets.all(8.0),
                    //                            child: child,
                    //                          ),
                    //                        ),
                    //                      );
                    //                    } else {
                    //                      return ClipRect(
                    //                        child: SlideTransition(
                    //                          position: outAnimation,
                    //                          child: Padding(
                    //                            padding: const EdgeInsets.all(8.0),
                    //                            child: child,
                    //                          ),
                    //                        ),
                    //                      );
                    //                    }

                    // Transition for three screens
                    if (child.key == ValueKey<int>(1)) {
                      if (_previousScreen == 0 ||
                          _previousScreen == 1 && screen != 2)
                        return inTransition;
                      return outTransition;
                    } else if (child.key == ValueKey<int>(2)) {
                      return inTransition;
                    } else {
                      return outTransition;
                    }
                  },
                  child: _returnTab(screen),
                );
              }),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Container _buildHeaderProfileInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.width / 3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/300"),
                    radius: MediaQuery.of(context).size.width / 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Iconsax.edit_2, size: 18, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vaibhav Kukreti',
                  style: getTitleTextStyle(context),
                ),
                Text(
                  '@vklightning',
                  style: getSubtitleTextStyle(context),
                ),
                SizedBox(height: 16),
                ZoomTapAnimation(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.5),
                            child: Icon(
                              Iconsax.add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "Add to Closet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
