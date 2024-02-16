import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String profilePictureUrl;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;

  const PostWidget({
    Key? key,
    required this.username,
    required this.profilePictureUrl,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [kSubtleShadow],
        border: Border.all(color: Colors.grey[100]!),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profilePictureUrl),
                  radius: 20.0,
                ),
                SizedBox(width: 16),
                Text(username),
                Spacer(),
                Icon(Iconsax.more),
              ],
            ),
          ),
          // Image
          SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
                child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            )),
          ),
          // Actions
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Iconsax.heart),
                    onPressed: () {},
                  ),
                  Text(likes.toString()),
                ],
              ),
              SizedBox(width: 16),
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
          // Caption
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(caption),
          ),
        ],
      ),
    );
  }
}
