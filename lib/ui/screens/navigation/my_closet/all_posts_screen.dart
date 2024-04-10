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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder(
              stream: _firestore
                  .collection('userPosts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: SizedBox.shrink());
                }
                final posts = snapshot.data!.docs;
                List<Widget> CurrentUserPosts = [];
                for (var post in posts) {
                  final entirePost = post.data() as Map<String, dynamic>;
                  final postUploader = entirePost['user'];
                  final userProfileURL = entirePost['userProfileURL'];
                  final postPicURL = entirePost['postPicURL'];
                  final postCaption = entirePost['caption'];
                  final postLikes = entirePost['likes'];
                  final postCategory = entirePost['category'];
                  final postComments = entirePost['comments'];
                  final postTimestamp = entirePost['timestamp'];

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
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageUrl: postPicURL,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: currTheme
                                            .textTheme.bodyMedium!.color,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.7),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Iconsax.heart,
                                            color: Colors.white, size: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(width: 12),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage:
                                        NetworkImage(userProfileURL),
                                  ),
                                  SizedBox(width: 8),
                                  Text(postCaption),
                                ],
                              ),
                              SizedBox(height: 6),
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '#' + postCategory,
                                  style: TextStyle(
                                      color:
                                          currTheme.textTheme.bodyMedium!.color,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                  CurrentUserPosts.add(userPost);
                }
                return Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 0.7,
                      children: CurrentUserPosts,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
