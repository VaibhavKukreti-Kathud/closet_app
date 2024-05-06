import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChatOneScreen extends StatefulWidget {
  const ChatOneScreen({super.key, required this.user});
  final AppUser user;
  @override
  State<ChatOneScreen> createState() => _ChatOneScreenState();
}

class _ChatOneScreenState extends State<ChatOneScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        scrolledUnderElevation: 0.0,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "UserName",
              style: TextStyle(
                color: currTheme.textTheme.headlineMedium!.color,
              ),
            ),
            SizedBox(width: 4),
            Icon(CupertinoIcons.chevron_forward, size: 16),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: currTheme.scaffoldBackgroundColor,
                          border: Border.all(
                            color: currTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.03),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                              color: Colors.black.withOpacity(0.03),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Hello",
                          style: TextStyle(
                            color: currTheme.textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                      ),
                      child: Icon(
                        Iconsax.send_1,
                        color: currTheme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
