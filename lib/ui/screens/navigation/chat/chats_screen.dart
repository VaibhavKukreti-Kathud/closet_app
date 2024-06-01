import 'dart:ui';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/chat/contact_search_screen.dart';
import 'package:closet_app/ui/screens/navigation/chat/group_chat.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'chat_one_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen>
    with TickerProviderStateMixin {
  ScrollController _chatController = ScrollController();
  ScrollController _groupController = ScrollController();

  bool showTabSwitcher = true;

  @override
  void initState() {
    _chatController.addListener(() {
      if (_chatController.position.activity!.isScrolling) {
        setState(() {
          showTabSwitcher = false;
        });
      }
      if (_chatController.position.atEdge) {
        bool isTop = _chatController.position.pixels == 0;
        if (isTop) {
          setState(() {
            showTabSwitcher = true;
          });
        } else {}
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    TabController tabController = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 400));
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text(
          'Chats',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactSearchScreen()));
                },
                child: Icon(
                  Iconsax.search_normal,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            labelStyle: getSubtitleTextStyle(context).copyWith(fontSize: 12),
            labelColor: currTheme.textTheme.bodyMedium!.color,
            unselectedLabelColor:
                currTheme.textTheme.bodyMedium!.color!.withOpacity(0.2),
            indicator: BoxDecoration(
              color: currTheme.appBarTheme.backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: currTheme.dividerColor,
                  width: 3,
                ),
              ),
            ),
            controller: tabController,
            tabs: [
              Tab(
                icon: Icon(
                  Iconsax.message,
                  color: currTheme.iconTheme.color!.withOpacity(0.5),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: "Chats",
              ),
              Tab(
                icon: Icon(
                  Iconsax.messages,
                  color: currTheme.iconTheme.color!.withOpacity(0.5),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: "Groups",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                StreamBuilder(
                    stream: _firestore
                        .collection(FirestoreConstants.USER_COLLECTION)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        controller: _chatController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final AppUser user = AppUser.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatOneScreen(user: user)));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      user.pfpUrl ??
                                          'https://picsum.photos/60'),
                                  radius:
                                      MediaQuery.of(context).size.width / 16,
                                ),
                                title: Text(
                                  user.fullName ?? 'User',
                                  style: TextStyle(
                                      color: currTheme
                                          .textTheme.bodyMedium!.color),
                                ),
                                subtitle: Text(
                                  'Hey!',
                                  style: TextStyle(
                                      color: currTheme
                                          .textTheme.bodyMedium!.color),
                                ),
                                trailing: Text(
                                  '12:00pm',
                                  style: TextStyle(
                                      color: currTheme
                                          .textTheme.bodyMedium!.color),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                margin: EdgeInsets.symmetric(horizontal: 80),
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    color: currTheme
                                        .textTheme.bodyMedium!.color!
                                        .withOpacity(0.2)),
                              ),
                              SizedBox(height: index == 10 ? 120 : 2),
                            ],
                          );
                        },
                      );
                    }),
                Scaffold(
                  body: ListView.builder(
                    itemCount: 1,
                    controller: _groupController,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GroupChatScreen()));
                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("https://picsum.photos/300"),
                                radius: MediaQuery.of(context).size.width / 16,
                              ),
                              title: Text(
                                'Group chat test',
                                style: TextStyle(
                                    color:
                                        currTheme.textTheme.bodyMedium!.color),
                              ),
                              subtitle: Text(
                                'User: Hey!',
                                style: TextStyle(
                                    color:
                                        currTheme.textTheme.bodyMedium!.color),
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '12:00pm',
                                    style: TextStyle(
                                        color: currTheme
                                            .textTheme.bodyMedium!.color),
                                  ),
                                  AvatarStack(
                                    width: 65,
                                    height: 28,
                                    borderWidth: 5,
                                    borderColor: Colors.white,
                                    avatars: [
                                      NetworkImage("https://picsum.photos/30"),
                                      NetworkImage("https://picsum.photos/30"),
                                      NetworkImage("https://picsum.photos/30"),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            height: 0.5,
                            margin: EdgeInsets.symmetric(horizontal: 80),
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                color: currTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.2)),
                          ),
                          SizedBox(height: 2),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
