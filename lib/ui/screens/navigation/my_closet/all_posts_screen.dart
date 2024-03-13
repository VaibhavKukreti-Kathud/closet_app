import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                stream: _firestore.collection('userPosts').orderBy('timestamp',descending: true).snapshots(),
                builder: ( BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData){
                    return Center(
                        child: SizedBox.shrink()
                    );
                  }
                  final posts = snapshot.data!.docs;
                  List<GestureDetector> CurrentUserPosts = [];
                  for (var post in posts){
                    final entirePost = post.data() as Map<String,dynamic>;
                    final postID = entirePost['id'];
                    final postUploader = entirePost['user'];
                    final userProfileURL = entirePost['userProfileURL'];
                    final postPicURL = entirePost['postPicURL'];
                    final postCaption = entirePost['caption'];
                    final postLikes = entirePost['likes'];
                    final postCategory = entirePost['category'];
                    final postComments = entirePost['comments'];
                    final postTimestamp = entirePost['timestamp'];

                    final userPost = GestureDetector(
                      onTap: (){
                        // send to expanded post screen with all other info.
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: postPicURL,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(
                                    child: CircularProgressIndicator(value: downloadProgress.progress,color: currTheme.textTheme.bodyMedium!.color,)
                                ),
                            errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                          ),
                        ),
                      ),
                    );

                    CurrentUserPosts.add(userPost);

                  }
                  return Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      children: CurrentUserPosts,
                    ),
                  );
                }
            )
          ],
        ),
    );
  }
}