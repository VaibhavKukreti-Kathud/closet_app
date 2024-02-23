import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Group Name",
              style: getSubHeadTextStyle(context),
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: ListView(
                  reverse: true,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage("https://picsum.photos/30"),
                        ),
                        SizedBox(width: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: InputBorder.none,
                          hintText: "Type a message",
                        ),
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
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
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
