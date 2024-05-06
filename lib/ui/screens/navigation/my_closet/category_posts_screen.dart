import 'package:closet_app/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';

class CategoryPostsScreen extends StatefulWidget {
  CategoryPostsScreen({required this.categoryName});

  final String categoryName;

  @override
  State<CategoryPostsScreen> createState() => _CategoryPostsScreenState();
}

class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'My ${widget.categoryName} Posts',
          style: TextStyle(fontSize: 36.0, fontFamily: 'Philosopher'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              for (int i = 1; i <= 5; ++i)
                PostWidget(
                  post: Post(
                    postId: '',
                    postedByName: 'User $i',
                    profilePfp:
                        'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg',
                    imageUrl:
                        'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg',
                    category: widget.categoryName,
                    caption: '',
                    postedAt: Timestamp.now(),
                    postedById: '',
                  ),
                ),
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: ShapeBorder.lerp(StadiumBorder(), StadiumBorder(), 0.0),
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
