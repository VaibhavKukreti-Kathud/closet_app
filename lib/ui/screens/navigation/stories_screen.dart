import 'package:flutter/material.dart';
import 'package:closet_app/ui/screens/navigation/widget/story_widget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width/2 - 20.0;
    final itemHeight = MediaQuery.of(context).size.height/3 - 40.0;
    print('Aspect ratio is : ${itemWidth/itemHeight}');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text('Stories',style: TextStyle(fontSize: 40.0,fontFamily: 'Philosopher'),),
          backgroundColor: Colors.white,
        ),
        body: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth/itemHeight > 1) ? 0.7 : 0.6,
                  children: [
                    for(int i = 1;i <=12; ++i)
                      StoryWidget(
                        username: "username",
                        profilePictureUrl: "https://picsum.photos/80",
                        imageUrl: "https://picsum.photos/800",
                        likes: 50,
                        comments: 12,
                      )
                  ],
                ),
              ),
            ]
        )
    );
  }
}