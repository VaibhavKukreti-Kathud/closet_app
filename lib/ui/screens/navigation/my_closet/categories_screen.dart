// import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:closet_app/ui/screens/navigation/my_closet/all_posts_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:closet_app/ui/screens/navigation/my_closet/wardrobe_tile.dart';
// import 'package:image_picker/image_picker.dart';

final _firestore = FirebaseFirestore.instance;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  bool shouldSpin = false;

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return LoadingOverlay(
        isLoading: shouldSpin,
        color: currTheme.textTheme.bodyMedium!.color,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              StreamBuilder(
                  stream: _firestore.collection('Categories').orderBy('timestamp',descending: true).snapshots(),
                  builder: ( BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData){
                      return Center(
                          child: SizedBox.shrink()
                      );
                    }
                    final categories = snapshot.data!.docs;
                    List<WardrobeTile> CurrentCategories = [];
                    for (var category in categories){
                      final entireCategory = category.data() as Map<String,dynamic>;
                      final categoryID = category.id;
                      final categoryUploader = entireCategory['user'];
                      final wardrobeCategpry = entireCategory['category'];
                      final categoryImage = entireCategory['categoryUrl'];
                      final numOfItems = entireCategory['numItems'];
                      final postTimestamp = entireCategory['timestamp'];

                      final userCategory = WardrobeTile(
                          wardrobeCategory: wardrobeCategpry,
                          imgUrl: categoryImage,
                          numItems: numOfItems,
                          categoryID : categoryID
                      );

                      CurrentCategories.add(userCategory);
                    }
                    return Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        childAspectRatio: 1.8 / 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        children: CurrentCategories,
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      );
  }
}