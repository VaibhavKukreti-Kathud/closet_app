import 'package:flutter/material.dart';
import 'package:closet_app/ui/screens/navigation/widget/other_users_tile.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
        backgroundColor: currTheme.scaffoldBackgroundColor,
        appBar: AppBar(
            iconTheme: currTheme.iconTheme,
            scrolledUnderElevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Divider(
                height: 1,
                color: Colors.grey.shade100,
              ),
            ),
            backgroundColor: currTheme.appBarTheme.backgroundColor,
            title: Text(
              'Followers',
              style: TextStyle(
                  color: currTheme.textTheme.bodyText1!.color, fontSize: 26),
            )),
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 16,
                ),
                OtherUsersTile(
                    username: 'vkukreti07',
                    emailID: 'vkukreti18@gmail.com',
                    alreadyFollowing: false),
                OtherUsersTile(
                    username: 'itsMeShashwat',
                    emailID: 'saxena06@gmail.com',
                    alreadyFollowing: true),
                OtherUsersTile(
                    username: 'anu1roy',
                    emailID: 'itsArunRoy13@gmail.com',
                    alreadyFollowing: true),
                OtherUsersTile(
                    username: 'saluja_vaibhav',
                    emailID: 'vaibhavsaluja48@gmail.com',
                    alreadyFollowing: false),
                OtherUsersTile(
                    username: 'vkukreti07',
                    emailID: 'vkukreti18@gmail.com',
                    alreadyFollowing: false),
                OtherUsersTile(
                    username: 'itsMeShashwat',
                    emailID: 'saxena06@gmail.com',
                    alreadyFollowing: true),
                OtherUsersTile(
                    username: 'anu1roy',
                    emailID: 'itsArunRoy13@gmail.com',
                    alreadyFollowing: true),
                OtherUsersTile(
                    username: 'saluja_vaibhav',
                    emailID: 'vaibhavsaluja48@gmail.com',
                    alreadyFollowing: false),
              ],
            ))
          ],
        ));
  }
}
