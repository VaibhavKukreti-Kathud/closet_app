// import 'dart:math';
import 'dart:ui';
// import 'package:closet_app/models/wardrobe_category_model.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/all_posts_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
// import 'package:closet_app/ui/screens/navigation/my_closet/categories_grid.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/categories_screen.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/posts_list.dart';
import 'package:closet_app/ui/screens/navigation/profile_settings_screen.dart';
// import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

final _firestore = FirebaseFirestore.instance;

class MyClosetScreen extends StatefulWidget {
  const MyClosetScreen({super.key});

  @override
  State<MyClosetScreen> createState() => _MyClosetScreenState();
}

class _MyClosetScreenState extends State<MyClosetScreen> with TickerProviderStateMixin {
  TabController? tabController;
  ValueNotifier<int> _currentScreen = ValueNotifier<int>(0);
  int _previousScreen = 0;
  XFile? selectedCategoryFile;
  String? categoryImageURL;
  bool shouldSpin = false;

  _returnTab(int screen) {
    switch (screen) {
      case 1:
        return CategoriesScreen(
          key: ValueKey<int>(1),
        );
      case 0:
        return AllPostsScreen(
          key: ValueKey<int>(0),
        );
    }
  }

  void showDialogWithFields(BuildContext context,ThemeData currTheme) {
    showDialog(
      context: context,
      builder: (_) {
        var categoryController = TextEditingController();
        return AlertDialog(
          backgroundColor: currTheme.dialogTheme.backgroundColor,
          title: Text('Add Category',
            style: TextStyle(
              color: currTheme.textTheme.bodyMedium!.color,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: categoryController,
                  style: TextStyle(
                      color: currTheme.textTheme.bodyMedium!.color
                  ),
                  decoration: InputDecoration(
                      hintText: 'Enter a new category of clothing',
                      hintStyle: TextStyle(
                          color: currTheme.textTheme.bodyMedium!.color
                      )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () async{
                      selectedCategoryFile = (await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery));
                      setState(() {

                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => currTheme.dialogTheme.backgroundColor ?? Colors.teal)
                    ),
                    child: Text(
                      'Choose Image',
                      style: TextStyle(fontSize: 20.0,color: currTheme.textTheme.bodyMedium!.color),
                    )
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style:TextStyle(
                    color: currTheme.textTheme.bodyMedium!.color
                ),
              ),
            ),
            TextButton(
              onPressed: () async{
                String cat = categoryController.text;
                categoryController.clear();
                Navigator.pop(context);
                setState(() {
                  shouldSpin = true;
                });
                // WardrobeCategory wardrobeCat = WardrobeCategory(name: cat, image: imgUrl);
                // add it to database
                String fileName = DateTime.now().microsecondsSinceEpoch.toString() + 'eashanbhardwaj02@gmail.com';

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referencePostImages = referenceRoot.child('categories');

                Reference referenceCurrentPost = referencePostImages.child(fileName);

                try{
                  // await referenceCurrentPost.putFile(File(selectedImageFile!.path));
                  await referenceCurrentPost.putData(await selectedCategoryFile!.readAsBytes());
                  categoryImageURL = await referenceCurrentPost.getDownloadURL();
                  // print('debug statement here : $imageURL');
                  _firestore.collection('Categories').add({
                    'user': 'eashanbhardwaj02@gmail.com',
                    'category': cat,
                    'categoryUrl' : categoryImageURL,
                    'numItems': 0.0,
                    'timestamp': DateTime.now().microsecondsSinceEpoch
                  });
                  setState(() {
                    shouldSpin = false;
                  });

                } catch (e) {
                  print('Error occured : $e');
                }
              },
              child: Text(
                'Add',
                style:TextStyle(
                    color: currTheme.textTheme.bodyMedium!.color
                ),
              ),
            ),
          ],
        );
      },
    );
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
    var currTheme = Theme.of(context);
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
                  onTap: () {
                    showDialogWithFields(context, currTheme);
                  },
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
                            "Add a Category",
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
