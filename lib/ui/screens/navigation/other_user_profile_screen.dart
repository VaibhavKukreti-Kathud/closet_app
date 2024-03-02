import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OtherUserProfileScreen extends StatefulWidget {
  OtherUserProfileScreen({required this.alreadyFollowing});

  final bool alreadyFollowing;

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {

  showPostsChecker(bool alreadyFollowing){
    if (!alreadyFollowing){
      return Expanded(
        child: Container(
          child: Center(
            child: Text('You don\'t currently follow this person. Follow them now to view their posts.',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 30),
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(13, (index) {
            return Image.network("https://picsum.photos/300");
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('User\'s Profile',style: TextStyle(fontSize: 36.0,fontFamily: 'Philosopher')),
      ),
      body: Column(
        children: [
          _buildHeaderProfileInfo(context,widget.alreadyFollowing),
          showPostsChecker(widget.alreadyFollowing)
        ],
      ),
    );
  }
}

Container _buildHeaderProfileInfo(BuildContext context,bool alreadyFollowing) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    height: MediaQuery.of(context).size.width * 2 / 5,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/300"),
              radius: MediaQuery.of(context).size.width / 8,
            ),
          ),
        ),
        Expanded(
          flex: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Vaibhav Kukreti',
                  style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.normal)
              ),
              Text(
                '@vklightning',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text('100',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      Text('Followers',style: TextStyle(fontSize: 16.0,color: Colors.black),)
                    ],
                  ),
                  SizedBox(width: 40.0,),
                  Column(
                    children: [
                      Text('80',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      Text('Following',style: TextStyle(fontSize: 16.0,color: Colors.black),)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              ZoomTapAnimation(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10),
                  child: Center(
                    child: Text(
                      alreadyFollowing ? "Unfollow" : "Follow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}