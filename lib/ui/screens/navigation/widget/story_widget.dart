import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StoryWidget extends StatelessWidget {
  final String username;
  final String profilePictureUrl;
  final String imageUrl;
  final int likes;
  final int comments;

  const StoryWidget({
    Key? key,
    required this.username,
    required this.profilePictureUrl,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: (){},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [kSubtleShadow],
            border: Border.all(color: Colors.grey[100]!),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          margin: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 12.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          children: [
                            IconButton(
                              icon: Icon(Iconsax.heart),
                              onPressed: () {},
                            ),
                            Text(likes.toString()),
                          ]
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Iconsax.message),
                            onPressed: () {},
                          ),
                          Text(comments.toString()),
                        ],
                      ),
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }
}