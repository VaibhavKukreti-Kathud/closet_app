import 'package:closet_app/constants.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/post/full_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StoryWidget extends StatelessWidget {
  final String username;
  final String profilePictureUrl;
  final String imageUrl;

  const StoryWidget({
    Key? key,
    required this.username,
    required this.profilePictureUrl,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Scaffold()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: currTheme.scaffoldBackgroundColor,
            boxShadow: [kSubtleShadow],
            border: Border.all(
                color: currTheme.textTheme.bodyMedium!.color ??
                    Colors.grey.shade100),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          margin: EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 12),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profilePictureUrl),
                    radius: 20.0,
                  ),
                  SizedBox(width: 10),
                  Text(username),
                  Spacer(),
                  Icon(Iconsax.more),
                ],
              ),
            ),
            // Image
            SizedBox(height: 12),
            Container(
              child: Image(
                image: NetworkImage('${imageUrl}'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
          ]),
        ));
  }
}
