import 'package:closet_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserDetailsScreen extends StatelessWidget {
  const AddUserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<UserProvider>().signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
