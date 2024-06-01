import 'dart:developer';

import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_options_screen.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpDetailsScreen extends StatefulWidget {
  const SignUpDetailsScreen({super.key, required this.email});
  final String email;

  @override
  State<SignUpDetailsScreen> createState() => _SignUpDetailsScreenState();
}

class _SignUpDetailsScreenState extends State<SignUpDetailsScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _nameFilled = false;
  bool passwordFilled = false;
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Center(child: IntroBranding()),
          SizedBox(height: 32),
          Text('Signup',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 32),
          Text('Name'),
          SizedBox(height: 4),
          CustomField(
            controller: _nameController,
            hintText: 'enter your full name',
            onEdit: (v) {
              setState(() {
                _nameFilled = true;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Password'),
          SizedBox(height: 4),
          CustomField(
            controller: _passwordController,
            hintText: 'minimum 8 characters',
            obscured: true,
            onEdit: (v) {
              setState(() {
                v.length >= 6 ? passwordFilled = true : passwordFilled = false;
              });
            },
          ),
          SizedBox(height: 24),
          CheckboxListTile.adaptive(
            contentPadding: EdgeInsets.only(left: 8),
            value: acceptTerms,
            onChanged: (val) {
              setState(() {
                acceptTerms = val!;
              });
            },
            title: Text(
              'I agree to the Terms of Service and Privacy Policy',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(height: 32),
          CustomButton(
            onPressed: () {
              try {
                log(widget.email + _passwordController.text);
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: widget.email, password: _passwordController.text)
                    .whenComplete(
                      () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                    );
              } catch (e) {
                print(e);
              }
            },
            text: 'Create Account',
          ),
        ],
      ),
    );
  }
}
