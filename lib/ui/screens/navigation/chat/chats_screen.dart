import 'dart:ui';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/chat/contact_search_screen.dart';
import 'package:closet_app/ui/screens/navigation/chat/group_chat.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
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
    TabController tabController = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 400));
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text(
          'Chats',
          style: TextStyle(
              fontSize: 30.0, color: currTheme.textTheme.titleLarge!.color),
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          TabBarView(
            controller: tabController,
            children: [
              Scaffold(
                body: ListView.builder(
                  controller: _chatController,
                  itemCount: 11,
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
                                        const ChatOneScreen()));
                          },
                          leading: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Hero(
                                      tag: index,
                                      child: Padding(
                                        padding: const EdgeInsets.all(64),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://picsum.photos/300"),
                                          maxRadius: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              200,
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Hero(
                              tag: index,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("https://picsum.photos/300"),
                                radius: MediaQuery.of(context).size.width / 16,
                              ),
                            ),
                          ),
                          title: Text(
                            'Vaibhav Kukreti',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                          subtitle: Text(
                            'Hey!',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                          trailing: Text(
                            '12:00pm',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          margin: EdgeInsets.symmetric(horizontal: 80),
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: currTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.2)),
                        ),
                        SizedBox(height: index == 10 ? 120 : 2),
                      ],
                    );
                  },
                ),
              ),
              Scaffold(
                body: ListView.builder(
                  itemCount: 8,
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
                                    builder: (context) => GroupChatScreen()));
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://picsum.photos/300"),
                            radius: MediaQuery.of(context).size.width / 16,
                          ),
                          title: Text(
                            'Birthday party 🎊',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                          subtitle: Text(
                            'Vaibhav: Hey!',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                          trailing: Text(
                            '12:00pm',
                            style: TextStyle(
                                color: currTheme.textTheme.bodyMedium!.color),
                          ),
                        ),
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            bottom: showTabSwitcher ? 16 : -75,
            right: 100,
            left: 100,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: showTabSwitcher
                        ? currTheme.textTheme.bodyMedium!.color
                                ?.withOpacity(0.1) ??
                            Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    blurRadius: 50,
                    spreadRadius: -10,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: currTheme.scaffoldBackgroundColor.withOpacity(0.1),
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  )
                ],
              ),
              duration: const Duration(milliseconds: 300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: currTheme.scaffoldBackgroundColor.withOpacity(0.5),
                    ),
                    child: TabBar(
                      labelStyle:
                          getSubtitleTextStyle(context).copyWith(fontSize: 12),
                      labelColor: currTheme.textTheme.bodyMedium!.color,
                      unselectedLabelColor:
                          currTheme.textTheme.bodyMedium!.color,
                      splashBorderRadius: BorderRadius.circular(30),
                      // dividerColor: currTheme.textTheme.bodyMedium!.color,
                      controller: tabController,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Iconsax.message,
                            color: currTheme.iconTheme.color,
                          ),
                          text: "Chats",
                        ),
                        Tab(
                          icon: Icon(
                            Iconsax.messages,
                            color: currTheme.iconTheme.color,
                          ),
                          text: "Groups",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
