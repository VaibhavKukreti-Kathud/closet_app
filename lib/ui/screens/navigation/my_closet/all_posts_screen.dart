import 'package:closet_app/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

final _firestore = FirebaseFirestore.instance;

class AllPostsScreen extends StatefulWidget {
  const AllPostsScreen({super.key});

  @override
  State<AllPostsScreen> createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return StreamBuilder(
        stream: _firestore.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: SizedBox.shrink());
          }
          final posts = snapshot.data!.docs;
          List<Widget> currentUserPosts = [];
          for (var post in posts) {
            final Post postModel =
                Post.fromMap(post.data() as Map<String, dynamic>);
            final userPost = Padding(
              padding:
                  const EdgeInsets.only(left: 3, right: 3, top: 4, bottom: 4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2), blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      // send to expanded post screen with all other info.
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: CachedNetworkImage(
                                  imageUrl: postModel.imageUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   bottom: 0,
                              //   right: 0,
                              //   child: Container(
                              //     margin: EdgeInsets.all(6),
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: Colors.grey.withOpacity(0.7),
                              //     ),
                              //     child: IconButton(
                              //       onPressed: () {},
                              //       icon: Icon(Iconsax.heart,
                              //           color: Colors.white, size: 20),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: CachedNetworkImageProvider(
                                    postModel.profilePfp),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text(
                                postModel.caption ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Iconsax.heart,
                                      color: Colors.black, size: 22),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          SizedBox(height: 6),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '#' + (postModel.category ?? 'Generic'),
                              style: TextStyle(
                                  color: currTheme.textTheme.bodyMedium!.color,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

            currentUserPosts.add(userPost);
          }
          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            childAspectRatio: 0.68,
            children: currentUserPosts,
          );
        });
  }
}
