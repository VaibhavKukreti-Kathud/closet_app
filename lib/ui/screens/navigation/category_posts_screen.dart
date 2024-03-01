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
        title: Text('My ${widget.categoryName} Posts',style: TextStyle(fontSize: 36.0,fontFamily: 'Philosopher'),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                children: [
                  for (int i = 1; i <= 5; ++i)
                    PostWidget(
                        username: "username",
                        profilePictureUrl: "https://picsum.photos/80",
                        imageUrl: "https://picsum.photos/400",
                        caption: "Caught in 8k",
                        likes: 12,
                        comments: 11
                    ),
                ],
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: ShapeBorder.lerp(StadiumBorder(), StadiumBorder(), 0.0),
        backgroundColor: Colors.teal,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}