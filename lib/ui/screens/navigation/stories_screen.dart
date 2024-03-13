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
    // print('Aspect ratio is : ${itemWidth/itemHeight}');
    var currTheme = Theme.of(context);
    return Scaffold(
        backgroundColor: currTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: currTheme.iconTheme,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text('Stories',style: TextStyle(fontSize: 40.0,fontFamily: 'Philosopher',color: currTheme.textTheme.titleLarge!.color),),
          backgroundColor: currTheme.appBarTheme.backgroundColor,
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
                      )
                  ],
                ),
              ),
            ]
        )
    );
  }
}