import 'package:closet_app/ui/screens/search/search_screen.dart';
import 'stories_screen.dart';
import 'package:flutter/cupertino.dart';
import 'widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  ScrollController _OOTDController = ScrollController();

  bool shouldShowOOTD = true;

  @override
  void initState() {
    _OOTDController.addListener(() {
      if (_OOTDController.position.activity!.isScrolling) {
        setState(() {
          shouldShowOOTD = false;
        });
      }
      if (_OOTDController.position.atEdge) {
        bool atTop = _OOTDController.position.pixels == 0;
        if (atTop) {
          setState(() {
            shouldShowOOTD = true;
          });
        } else {}
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Discover'),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Iconsax.search_normal),
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          if (shouldShowOOTD)
            Column(
              children: [
                Text(
                  'Outfit of the day',
                  style: TextStyle(fontSize: 28.0, fontFamily: 'Philosopher'),
                ),
                SizedBox(
                  height: 4.0,
                ),
                ZoomTapAnimation(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoriesScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0)),
                          child: Image(
                            image: NetworkImage('https://picsum.photos/400'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                                    radius:
                                        MediaQuery.of(context).size.width / 25,
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        'username',
                                        style: TextStyle(fontSize: 16.0),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.heart),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text('12'),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Icon(Iconsax.message),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text('11'),
                                ],
                              ),
                              Text('Explore more!',
                                  style: TextStyle(fontSize: 17.0))
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ZoomTapAnimation(
                              onTap: () {
                                // print('Going to stories page');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoriesScreen()));
                              },
                              child: Icon(Icons.arrow_forward_ios)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          SizedBox(
            height: 12.0,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: ListView(
              controller: _OOTDController,
              children: [
                for (int i = 0; i < 10; i++)
                  PostWidget(
                      username: "username",
                      profilePictureUrl: "https://picsum.photos/80",
                      imageUrl: "https://picsum.photos/400",
                      caption: "Caught in 8k",
                      likes: 12,
                      comments: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
