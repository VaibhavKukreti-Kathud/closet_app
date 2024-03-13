import 'package:closet_app/ui/screens/navigation/my_closet/post_preview_page.dart';
import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

final _firestore = FirebaseFirestore.instance;

class SpecificPostsScreen extends StatefulWidget {
  SpecificPostsScreen({required this.category,required this.categoryID});

  final String category;
  final String categoryID;

  @override
  State<SpecificPostsScreen> createState() => _SpecificPostsScreenState();
}

class _SpecificPostsScreenState extends State<SpecificPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text('All ${widget.category} Posts',style: TextStyle(fontSize: 34.0,color: currTheme.textTheme.titleLarge!.color),),
      ),
      body: Column(
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
                List<PostWidget> CurrentUserPosts = [];
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

                  if (postCategory == widget.category){
                    final userPost = PostWidget(
                        username: postUploader,
                        profilePictureUrl: userProfileURL,
                        imageUrl: postPicURL,
                        caption: postCaption,
                        likes: postLikes,
                        comments: postComments
                    );

                    CurrentUserPosts.add(userPost);
                  }
                }
                return Expanded(
                  child: ListView(
                    // reverse: true,
                    // padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                    shrinkWrap: true,
                    children: CurrentUserPosts,
                  ),
                );
              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPreviewPage(currentCategory: widget.category,currentCategoryID: widget.categoryID,)));
        },
        backgroundColor: currTheme.floatingActionButtonTheme.backgroundColor,
        child: Icon(Icons.add,color: currTheme.iconTheme.color,),
      ),
    );
  }
}