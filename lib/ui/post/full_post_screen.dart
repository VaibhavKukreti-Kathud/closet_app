import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/models/post_model.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FullPostScreen extends StatelessWidget {
  FullPostScreen({super.key, required this.post});
  final Post post;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(post.postedByName),
        actions: [
          IconButton(icon: Icon(Iconsax.more), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Hero(
                tag: post.postId,
                child: CachedNetworkImage(
                  imageUrl: post.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Skeletonizer(
                        enabled: true,
                        containersColor: kSecondaryColor,
                        child: Container());
                  },
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: currTheme.iconTheme.color),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(post.profilePfp),
                            radius: 20,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.postedByName,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${post.caption}',
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirestoreConstants.POSTS_COLLECTION)
                        .doc(post.postId)
                        .collection(FirestoreConstants.COMMENTS_COLLECTION)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Text('No comments yet'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var comment = snapshot.data!.docs[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: index == 0 ? 12 : 4,
                                bottom: 4),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    comment['profilePfp'],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment['commentedBy'],
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        comment['comment'],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [kSubtleShadow],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  SafeArea(
                    child: IconButton(
                      padding: EdgeInsets.all(16),
                      icon: Icon(
                        Iconsax.send_1,
                        color: kSecondaryColor,
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection(FirestoreConstants.POSTS_COLLECTION)
                            .doc(post.postId)
                            .collection(FirestoreConstants.COMMENTS_COLLECTION)
                            .add({
                          'commentedBy': 'Vaibhav Kukreti',
                          'comment': commentController.text,
                          'profilePfp': 'https://via.placeholder.com/150',
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        commentController.clear();
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
