import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Comment 1'),
          ),
          ListTile(
            title: Text('Comment 2'),
          ),
          ListTile(
            title: Text('Comment 3'),
          ),
        ],
      ),
    );
  }
}
