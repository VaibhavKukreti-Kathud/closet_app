import 'dart:math';
import 'dart:ui';

import 'package:closet_app/ui/screens/navigation/my_closet/mycloset_screen.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      shrinkWrap: true,
      childAspectRatio: 1.8 / 1,
      physics: NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 200.0,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: MyClosetScreen.categories.map((category) {
        return ZoomTapAnimation(
          onTap: () {},
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
                image: NetworkImage(category.image),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              category.name,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text("${Random().nextInt(12) + 1} Items",
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
      }).toList(),
    );
  }
}
