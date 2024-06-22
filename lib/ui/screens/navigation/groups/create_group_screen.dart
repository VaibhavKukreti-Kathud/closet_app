import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Group'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomSearchField(
              controller: TextEditingController(),
              hintText: 'Search contacts',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://picsum.photos/90'),
                    ),
                    title: Text('User $index'),
                    trailing: Icon(Icons.check),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
