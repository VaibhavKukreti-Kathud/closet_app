import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: TextFormField(
                          key: ValueKey('name'),
                          keyboardType: TextInputType.name,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : 'Invalid email',
                          onSaved: (value) => _email = value!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            labelText: 'Full name',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: TextFormField(
                          focusNode: _emailFocusNode,
                          key: ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : 'Invalid email',
                          onSaved: (value) => _email = value!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: TextFormField(
                          focusNode: _passwordFocusNode,
                          key: ValueKey('password'),
                          obscureText: true,
                          validator: (value) => value!.isEmpty
                              ? 'Password cannot be empty'
                              : null,
                          onSaved: (value) => _password = value!,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              fillColor: Colors.grey[100],
                              labelStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: TextFormField(
                          key: ValueKey('confirm_email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : 'Invalid email',
                          onSaved: (value) => _email = value!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            labelText: 'Confirm password',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ZoomTapAnimation(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: kAccentColor,
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  size: 16,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
