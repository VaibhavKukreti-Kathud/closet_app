import 'package:flutter/material.dart';
import 'package:closet_app/ui/screens/navigation/widget/other_users_tile.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: Text('Following',
            style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Philosopher'
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child:  ListView(
                  children: [
                    OtherUsersTile(username: 'vkukreti07', emailID: 'vkukreti18@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'itsMeShashwat', emailID: 'saxena06@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'anu1roy', emailID: 'itsArunRoy13@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'saluja_vaibhav', emailID: 'vaibhavsaluja48@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'vkukreti07', emailID: 'vkukreti18@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'itsMeShashwat', emailID: 'saxena06@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'anu1roy', emailID: 'itsArunRoy13@gmail.com', alreadyFollowing: true),
                    OtherUsersTile(username: 'saluja_vaibhav', emailID: 'vaibhavsaluja48@gmail.com', alreadyFollowing: true),
                  ],
                )
            )
          ],
        )
    );
  }
}