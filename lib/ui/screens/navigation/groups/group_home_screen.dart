import 'package:closet_app/constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GroupHomeScreen extends StatefulWidget {
  const GroupHomeScreen({
    super.key,
  });

  @override
  State<GroupHomeScreen> createState() => _GroupHomeScreenState();
}

class _GroupHomeScreenState extends State<GroupHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Group name"),
                Text(
                  '10 members',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                          color: Colors.grey.shade300,
                          blurStyle: BlurStyle.inner),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: 'Discovery',
                      ),
                      Tab(
                        text: 'Group chat',
                      ),
                    ],
                    dividerHeight: 0,
                    splashBorderRadius: BorderRadius.circular(30),
                    unselectedLabelColor: Colors.grey.shade800,
                    labelStyle: TextStyle(color: Colors.white),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Iconsax.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Stack(
                  children: [
                    MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 8,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        double height = MediaQuery.of(context).size.height;
                        return Container(
                          height: index == 0 ? height * 0.3 : height * 0.4,
                          margin: EdgeInsets.only(top: index < 2 ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Skeletonizer(
                                  enabled: true,
                                  effect:
                                      ShimmerEffect(baseColor: Colors.black),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Text(
                                          'Borrow',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                currTheme.colorScheme.primary,
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        child: Text(
                                          'Message',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withAlpha(0),
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: ListView(
                            reverse: true,
                            children: [
                              ChatMessageTile(isSent: true),
                              ChatMessageTile(isSent: false),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ZoomTapAnimation(
                              onTap: () {},
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.send,
                                  color: currTheme.iconTheme.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
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

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile({
    required this.isSent,
    super.key,
  });
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    ThemeData currTheme = Theme.of(context);
    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: currTheme.colorScheme.tertiary.withOpacity(isSent ? 1 : 0.6),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isSent ? 0 : 8),
              topLeft: Radius.circular(isSent ? 8 : 0),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSent
                  ? SizedBox()
                  : Text(
                      'Vaibhav',
                      style: TextStyle(
                          fontSize: 12,
                          color: currTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.7)),
                    ),
              Text(
                'Hello there! How is everything going?',
                style: TextStyle(
                  fontSize: 16,
                  color: currTheme.textTheme.bodyMedium!.color,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '6:58pm',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        currTheme.textTheme.bodyMedium!.color!.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
