import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userId});
  final String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: FutureBuilder(
        future: context.read<UserProvider>().fetchUserById(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final AppUser user = snapshot.data!;
          return Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.pfpUrl ?? ''),
              ),
              Text(user.fullName ?? 'User'),
              Text("Email"),
              Text("Phone"),
              Text("Bio"),
            ],
          );
        },
      ),
    );
  }
}
