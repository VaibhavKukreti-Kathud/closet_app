import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/chat/chat_functions.dart';
import 'package:closet_app/ui/screens/navigation/chat/widgets/chat_bubble.dart';
import 'package:closet_app/ui/screens/settings/other_user_profile_screen.dart';
import 'package:closet_app/ui/user_profile/user_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChatOneScreen extends StatefulWidget {
  const ChatOneScreen({super.key, required this.user});
  final AppUser user;
  @override
  State<ChatOneScreen> createState() => _ChatOneScreenState();
}

class _ChatOneScreenState extends State<ChatOneScreen> {
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Iconsax.more),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: currTheme.scaffoldBackgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Iconsax.text_block),
                          title: Text("Block"),
                        ),
                        ListTile(
                          leading: Icon(Iconsax.trash),
                          title: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomTapAnimation(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return OtherUserProfileScreen(
                    user: widget.user,
                  );
                }));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.pfpUrl ?? ''),
                radius: 15,
              ),
            ),
            SizedBox(width: 16),
            Text(
              widget.user.fullName ?? '',
              style: TextStyle(
                color:
                    currTheme.textTheme.headlineMedium!.color!.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatFunctions().fetchChatMessages(
                    context.read<UserProvider>().appUser!.id, widget.user.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        isSent: snapshot.data![index].senderId ==
                            context.read<UserProvider>().appUser!.id,
                        message: snapshot.data![index].messageText,
                      );
                    },
                  );
                },
              ),
              // child: ListView.builder(
              //   reverse: true,
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 16,
              //   ),
              //   itemCount: 10,
              //   itemBuilder: (context, index) {
              //     return ChatBubble(
              //       isSent: index % 2 == 0,
              //       message: "Hello",
              //     );
              //   },
              // ),
            ),
            Divider(
              height: 1,
              color: Colors.grey.shade100,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2))),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        // Send message
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(context.read<UserProvider>().appUser!.id)
                            .collection('messages')
                            .doc(widget.user.id)
                            .collection('messages')
                            .add({
                          'messageText': _messageController.text,
                          'senderId': context.read<UserProvider>().appUser!.id,
                          'timestamp': Timestamp.now(),
                        });
                        _messageController.clear();
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                      ),
                      child: Icon(
                        Iconsax.send_1,
                        color: currTheme.scaffoldBackgroundColor,
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
    );
  }
}
