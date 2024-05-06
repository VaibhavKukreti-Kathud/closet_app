import 'package:closet_app/ui/screens/navigation/my_closet/widgets/post_preview_page.dart';
import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../models/post_model.dart';

final _firestore = FirebaseFirestore.instance;

class CategoricPostsScreen extends StatefulWidget {
  CategoricPostsScreen({required this.category, required this.categoryID});

  final String category;
  final String categoryID;

  @override
  State<CategoricPostsScreen> createState() => _CategoricPostsScreenState();
}

class _CategoricPostsScreenState extends State<CategoricPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'All ${widget.category} Posts',
        ),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('posts')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final posts = snapshot.data!.docs;
              List<Widget> CurrentUserPosts = [];
              for (var post in posts) {
                final Post postModel =
                    Post.fromMap(post.data() as Map<String, dynamic>);
                if (postModel.category == widget.categoryID) {
                  final userPost = Padding(
                    padding: const EdgeInsets.only(
                        left: 3, right: 3, top: 4, bottom: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          // send to expanded post screen with all other info.
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currTheme.cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: currTheme.shadowColor,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                            border: Border.all(
                              color: currTheme.shadowColor,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              postModel.profilePfp),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      postModel.postedByName,
                                      style: TextStyle(
                                          color: currTheme
                                              .textTheme.bodyText1!.color,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl: postModel.imageUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  postModel.caption ?? '',
                                  style: TextStyle(
                                      color:
                                          currTheme.textTheme.bodyText1!.color,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: currTheme.iconTheme.color,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      postModel.likedBy.toString(),
                                      style: TextStyle(
                                          color: currTheme
                                              .textTheme.bodyText1!.color,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.comment,
                                      color: currTheme.iconTheme.color,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      postModel.comments!.length.toString(),
                                      style: TextStyle(
                                          color: currTheme
                                              .textTheme.bodyText1!.color,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  CurrentUserPosts.add(userPost);

                  return ListView(
                    children: CurrentUserPosts,
                  );
                }
              }
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostPreviewPage(
                        currentCategory: widget.category,
                        currentCategoryID: widget.categoryID,
                      )));
        },
        backgroundColor: currTheme.floatingActionButtonTheme.backgroundColor,
        child: Icon(
          Icons.add,
          color: currTheme.iconTheme.color,
        ),
      ),
    );
  }
}
