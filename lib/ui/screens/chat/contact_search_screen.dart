import 'package:flutter/material.dart';

class ContactSearchScreen extends StatelessWidget {
  const ContactSearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0.0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: currTheme.textTheme.bodyMedium!.color
            )
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('User $index',style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),),
          );
        },
      ),
    );
  }
}
