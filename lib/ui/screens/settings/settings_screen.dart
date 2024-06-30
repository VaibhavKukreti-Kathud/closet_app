import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:solar_icons/solar_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Email'),
            leading: Icon(SolarIconsOutline.letter),
            onTap: () {
              Navigator.pushNamed(context, '/email');
            },
          ),
          ListTile(
            title: Text('Password'),
            leading: Icon(SolarIconsOutline.password),
            onTap: () {
              Navigator.pushNamed(context, '/password');
            },
          ),
          ListTile(
            title: Text('Location'),
            leading: Icon(SolarIconsOutline.pointOnMap),
            onTap: () {
              Navigator.pushNamed(context, '/location');
            },
          ),
          ListTile(
            title: Text('Language'),
            leading: Icon(LineIcons.globeWithAfricaShown),
            onTap: () {
              Navigator.pushNamed(context, '/language');
            },
          ),
          ListTile(
            title: Text('Log out'),
            leading: Icon(LineIcons.alternateSignOut),
            onTap: () async {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Log out?'),
                  content: Text(
                      'Are you sure you want to log out of the application?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
