import 'dart:ui';
import 'package:closet_app/ui/screens/navigation/my_closet/categoric_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WardrobeTile extends StatelessWidget {
  WardrobeTile(
      {required this.wardrobeCategory,
      required this.imgUrl,
      required this.numItems,
      required this.categoryID});

  final String wardrobeCategory;
  final String imgUrl;
  final double numItems;
  final String categoryID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoricPostsScreen(
                      category: wardrobeCategory,
                      categoryID: categoryID,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 30,
              spreadRadius: -10,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 95, 95, 95).withOpacity(0.8),
              const Color.fromARGB(255, 95, 95, 95).withOpacity(0.07)
            ], stops: [
              0,
              0.5
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.maxFinite),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[700]!.withOpacity(0.3)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          wardrobeCategory,
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text("${numItems.toInt()} Items",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white.withOpacity(0.8))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
