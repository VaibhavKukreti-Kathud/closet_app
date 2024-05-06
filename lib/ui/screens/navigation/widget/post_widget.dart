import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/models/post_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/favorites/favorites_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/post/full_post_screen.dart';
import 'package:closet_app/ui/screens/settings/other_user_profile_screen.dart';
import 'package:closet_app/ui/user_profile/user_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLoading = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void likePost(String postId) {
    firestore
        .collection(FirestoreConstants.POSTS_COLLECTION)
        .doc(postId)
        .update({
      FirestoreConstants.LIKES_COLLECTION:
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  void unlikePost(String postId) {
    firestore
        .collection(FirestoreConstants.POSTS_COLLECTION)
        .doc(postId)
        .update({
      FirestoreConstants.LIKES_COLLECTION:
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  bool isLiked(String postId) {
    return widget.post.likedBy!
        .contains(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtherUserProfileScreen(alreadyFollowing: false),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.profilePfp),
                    radius: 20.0,
                  ),
                ),
                SizedBox(width: 16),
                Text(widget.post.postedByName),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      _buildPostMenuOptions(context, widget.post);
                    },
                    child: Icon(Iconsax.more)),
              ],
            ),
          ),
          // Image
          SizedBox(height: 12),
          GestureDetector(
            onDoubleTap: () async {
              if (isLiked(widget.post.postId)) {
                unlikePost(widget.post.postId);
              } else {
                likePost(widget.post.postId);
              }
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: widget.post.postId,
                    child: CachedNetworkImage(
                      imageUrl: widget.post.imageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        downloadProgress.progress == 100
                            ? isLoading = false
                            : isLoading = true;

                        return Skeletonizer(
                            enabled: isLoading,
                            containersColor: kSecondaryColor,
                            child: Container());
                      },
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: currTheme.iconTheme.color),
                    ),
                  ),
                  // LikeIconAnimationWidget(),
                ],
              ),
            ),
          ),
          // Actions
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: firestore
                      .collection('posts')
                      .doc(widget.post.postId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: SizedBox.shrink());
                    }
                    final post = Post.fromMap(
                        snapshot.data!.data() as Map<String, dynamic>);
                    return Row(
                      children: [
                        IconButton(
                          icon: (post.likedBy ?? []).contains(currentUserId)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border_outlined),
                          onPressed: () async {
                            if (isLiked(widget.post.postId)) {
                              unlikePost(widget.post.postId);
                            } else {
                              likePost(widget.post.postId);
                            }
                          },
                        ),
                        Text((post.likedBy ?? []).length.toString()),
                      ],
                    );
                  }),
              SizedBox(width: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Iconsax.message),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FullPostScreen(post: widget.post);
                      }));
                    },
                  ),
                  Text((widget.post.comments ?? []).length.toString()),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  context
                          .watch<FavoritesProvider>()
                          .isFavorite(widget.post.postId)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
                onPressed: () async {
                  context
                          .read<FavoritesProvider>()
                          .isFavorite(widget.post.postId)
                      ? await context
                          .read<FavoritesProvider>()
                          .removeFavorite(widget.post.postId)
                      : await context
                          .read<FavoritesProvider>()
                          .addFavorite(widget.post.postId);
                },
              ),
            ],
          ),
          // Caption
          widget.post.caption == null
              ? SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Text(widget.post.caption!),
                ),
        ],
      ),
    );
  }

  Future _buildPostMenuOptions(BuildContext context, Post post) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {},
              leading: Icon(Iconsax.flag),
              title: Text('Report post'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(CupertinoIcons.share),
              title: Text('Share'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Iconsax.text_block),
              title: Text('Block ${post.postedByName}'),
            ),
            post.postedById == context.read<UserProvider>().appUser!.id
                ? ListTile(
                    onTap: () {},
                    leading: Icon(Iconsax.close_circle),
                    title: Text('Delete'),
                  )
                : SizedBox(),
            SizedBox(
              height: 32,
            ),
          ],
        );
      },
    );
  }
}

class LikeIconAnimationWidget extends StatelessWidget {
  const LikeIconAnimationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.favorite, color: Colors.red, size: 100);
  }
}
