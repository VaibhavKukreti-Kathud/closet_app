// import 'dart:math';
import 'dart:io';
import 'dart:ui';
// import 'package:closet_app/models/wardrobe_category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/all_posts_screen.dart';
import 'package:closet_app/ui/post/add_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
// import 'package:closet_app/ui/screens/navigation/my_closet/categories_grid.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/categories_screen.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/widgets/posts_list.dart';
import 'package:closet_app/ui/screens/settings/settings_screen.dart';
// import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

final _firestore = FirebaseFirestore.instance;

class MyClosetScreen extends StatefulWidget {
  const MyClosetScreen({super.key});

  @override
  State<MyClosetScreen> createState() => _MyClosetScreenState();
}

class _MyClosetScreenState extends State<MyClosetScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  ValueNotifier<int> _currentScreen = ValueNotifier<int>(0);
  int _previousScreen = 0;
  XFile? selectedCategoryFile;
  String? categoryImageURL;
  bool shouldSpin = false;
  AppUser? currentAppUser;

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

  void showDialogWithFields(BuildContext context, ThemeData currTheme) {
    showDialog(
      context: context,
      builder: (_) {
        var categoryController = TextEditingController();
        return AlertDialog(
          backgroundColor: currTheme.dialogTheme.backgroundColor,
          title: Text(
            'Add Category',
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
                  style:
                      TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                  decoration: InputDecoration(
                      hintText: 'Enter a new category of clothing',
                      hintStyle: TextStyle(
                          color: currTheme.textTheme.bodyMedium!.color)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () async {
                      selectedCategoryFile = (await ImagePicker.platform
                          .getImageFromSource(source: ImageSource.gallery));
                      setState(() {});
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                currTheme.dialogTheme.backgroundColor ??
                                Colors.teal)),
                    child: Text(
                      'Choose Image',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: currTheme.textTheme.bodyMedium!.color),
                    ))
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),
              ),
            ),
            TextButton(
              onPressed: () async {
                String cat = categoryController.text;
                categoryController.clear();
                Navigator.pop(context);
                setState(() {
                  shouldSpin = true;
                });
                // WardrobeCategory wardrobeCat = WardrobeCategory(name: cat, image: imgUrl);
                // add it to database
                String fileName =
                    DateTime.now().microsecondsSinceEpoch.toString() +
                        'eashanbhardwaj02@gmail.com';

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referencePostImages =
                    referenceRoot.child('categories');

                Reference referenceCurrentPost =
                    referencePostImages.child(fileName);

                try {
                  // await referenceCurrentPost.putFile(File(selectedImageFile!.path));
                  await referenceCurrentPost
                      .putData(await selectedCategoryFile!.readAsBytes());
                  categoryImageURL =
                      await referenceCurrentPost.getDownloadURL();
                  // print('debug statement here : $imageURL');
                  _firestore.collection('Categories').add({
                    'user': 'eashanbhardwaj02@gmail.com',
                    'category': cat,
                    'categoryUrl': categoryImageURL,
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
                style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    currentAppUser = context.read<UserProvider>().appUser;
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text(
          'My Closet',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileSettingsScreen()));
              },
              child: Icon(
                Icons.settings,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          _buildHeaderProfileInfo(context),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Private posts',
                  style: TextStyle(
                    color: currTheme.textTheme.bodyMedium!.color,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // TabBar(
          //     onTap: (value) {
          //       _previousScreen = _currentScreen.value;
          //       _currentScreen.value = value;
          //     },
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     labelColor: currTheme.textTheme.bodyMedium!.color,
          //     unselectedLabelColor: currTheme.textTheme.bodyMedium!.color,
          //     // dividerColor: Colors.redAccent,
          //     dividerColor: currTheme.dividerColor,
          //     indicator: BoxDecoration(
          //         border: Border(
          //             bottom: BorderSide(
          //       color: currTheme.colorScheme.secondary,
          //       width: 2,
          //     ))),
          //     tabs: [
          //       Tab(
          //         text: "Posts",
          //       ),
          //       Tab(
          //         text: "Categories",
          //       ),
          //     ],
          //     controller: tabController),
          // ValueListenableBuilder<int>(
          //     valueListenable: _currentScreen,
          //     builder: (context, screen, child) {
          //       return AnimatedSwitcher(
          //         duration: Duration(milliseconds: 50),
          //         switchInCurve: Curves.easeOutCubic,
          //         switchOutCurve: Curves.easeInCubic,
          //         transitionBuilder:
          //             (Widget child, Animation<double> animation) {
          //           final inAnimation =
          //               Tween<double>(begin: 0, end: 1).animate(animation);
          //           final outAnimation =
          //               Tween<double>(begin: 0, end: 1).animate(animation);

          //           final Widget inTransition = ClipRect(
          //             child: FadeTransition(
          //               opacity: inAnimation,
          //               child: child,
          //             ),
          //           );

          //           final Widget outTransition = ClipRect(
          //             child: FadeTransition(
          //               opacity: outAnimation,
          //               child: child,
          //             ),
          //           );

          //           // Transition for three screens
          //           if (child.key == ValueKey<int>(1)) {
          //             if (_previousScreen == 0 ||
          //                 _previousScreen == 1 && screen != 2)
          //               return inTransition;
          //             return outTransition;
          //           } else if (child.key == ValueKey<int>(2)) {
          //             return inTransition;
          //           } else {
          //             return outTransition;
          //           }
          //         },
          //         child: _returnTab(screen),
          //       );
          //     }),
          // SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeaderProfileInfo(BuildContext context) {
    var currTheme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {}
                    },
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          context.read<UserProvider>().appUser!.pfpUrl ??
                              'https://www.picsum.photos/300'),
                      radius: MediaQuery.of(context).size.width / 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3,
                        ),
                      ),
                      padding: EdgeInsets.all(6),
                      child:
                          Icon(Iconsax.edit_2, size: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          currentAppUser!.fullName,
          style: TextStyle(
            color: currTheme.textTheme.bodyMedium!.color,
            fontSize: 16,
          ),
        ),
        Text(
          '@${currentAppUser!.email.split('@').first}',
          style: TextStyle(
            color: currTheme.textTheme.bodyMedium!.color!.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 24),
        // FutureBuilder(
        //     future: _firestore
        //         .collection(FirestoreConstants.USER_COLLECTION)
        //         .doc(currentAppUser!.id)
        //         .get(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text("Error: ${snapshot.error}");
        //       }

        //       return Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Text(
        //                   '6',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //                 Text(
        //                   'Posts',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Text(
        //                   '0',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //                 Text(
        //                   'Followers',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Text(
        //                   '0',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //                 Text(
        //                   'Following',
        //                   style: TextStyle(
        //                     color: currTheme.textTheme.bodyMedium!.color,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       );
        //     }),
      ],
    );
  }
}
