import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/expanded_story_screen.dart';
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
    var currTheme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExpandedStoryScreen(
                    username: username,
                    userImageURL: profilePictureUrl,
                    storyImageURL: imageUrl,
                    likes: likes,
                    comments: comments)));
      },
      child: Container(
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
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 500,
                              color: Colors.white,
                              child: ListView(
                                children: [
                                  ListTile(
                                    leading: Icon(Iconsax.bookmark),
                                    title: Text('Save'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.flag),
                                    title: Text('Report'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.link),
                                    title: Text('Copy Link'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.send),
                                    title: Text('Share to...'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.close_square),
                                    title: Text('Unfollow'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.volume_cross),
                                    title: Text('Mute'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.reserve),
                                    title: Text('Restrict'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.text_block),
                                    title: Text('Block'),
                                  ),
                                  ListTile(
                                    leading: Icon(Iconsax.close_circle),
                                    title: Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(Iconsax.more)),
                ],
              ),
            ),
            // Image
            SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                  child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 2.0,
                      color: currTheme.textTheme.bodyMedium!.color),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: currTheme.iconTheme.color),
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
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.bookmark_outline,
                  ),
                  onPressed: () {},
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
      ),
    );
  }
}
