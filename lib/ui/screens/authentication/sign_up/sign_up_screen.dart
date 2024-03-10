import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondFormKey = GlobalKey<FormState>();
  String _email = '';
  String fullName = '';
  String _confirmEmail = '';
  String _confirmPassword = '';
  String _password = '';
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final PageController _pageController = PageController();
  Animation<double>? _animation;
  AnimationController? _animationController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: LinearProgressIndicator(
            value: _animation?.value ?? 0,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              switch (value) {
                case 0:
                  Tween(begin: 0.5, end: 0).animate(_animationController!);
                  break;
                case 1:
                  Tween(begin: 0, end: 0.5).animate(_animationController!);
                  break;
                default:
                  Tween(begin: 0, end: 1).animate(_animationController!);
              }
            });
          },
          controller: _pageController,
          children: [
            _buildFirstPage(context),
            _buildSecondPage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Form(
              key: _firstFormKey,
              child: Column(
                children: <Widget>[
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(kBorderRadius),
                  //   child: TextFormField(
                  //     key: ValueKey('name'),
                  //     keyboardType: TextInputType.name,
                  //     validator: (value) => EmailValidator.validate(value!)
                  //         ? null
                  //         : 'Invalid email',
                  //     onSaved: (value) => _email = value!,
                  //     decoration: InputDecoration(
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //       labelText: 'Full name',
                  //       labelStyle: TextStyle(
                  //         fontSize: 16.0,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.grey[100],
                  //       border: InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       focusedBorder: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(kBorderRadius),
                  //   child: TextFormField(
                  //     focusNode: _emailFocusNode,
                  //     key: ValueKey('email'),
                  //     keyboardType: TextInputType.emailAddress,
                  //     validator: (value) => EmailValidator.validate(value!)
                  //         ? null
                  //         : 'Invalid email',
                  //     onSaved: (value) => _email = value!,
                  //     decoration: InputDecoration(
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //       labelText: 'Email',
                  //       labelStyle: TextStyle(
                  //         fontSize: 16.0,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.grey[100],
                  //       border: InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       focusedBorder: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(kBorderRadius),
                  //   child: TextFormField(
                  //     focusNode: _passwordFocusNode,
                  //     key: ValueKey('password'),
                  //     obscureText: true,
                  //     validator: (value) =>
                  //         value!.isEmpty ? 'Password cannot be empty' : null,
                  //     onSaved: (value) => _password = value!,
                  //     decoration: InputDecoration(
                  //         labelText: 'Password',
                  //         filled: true,
                  //         contentPadding: EdgeInsets.symmetric(
                  //             horizontal: 24, vertical: 12),
                  //         fillColor: Colors.grey[100],
                  //         labelStyle: TextStyle(
                  //           fontSize: 16.0,
                  //         ),
                  //         border: InputBorder.none,
                  //         enabledBorder: InputBorder.none,
                  //         focusedBorder: InputBorder.none),
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(kBorderRadius),
                  //   child: TextFormField(
                  //     key: ValueKey('confirm_email'),
                  //     keyboardType: TextInputType.emailAddress,
                  //     validator: (value) => EmailValidator.validate(value!)
                  //         ? null
                  //         : 'Invalid email',
                  //     onSaved: (value) => _email = value!,
                  //     decoration: InputDecoration(
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //       labelText: 'Confirm password',
                  //       labelStyle: TextStyle(
                  //         fontSize: 16.0,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.grey[100],
                  //       border: InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       focusedBorder: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 30),
                  // ZoomTapAnimation(
                  //   onTap: () {
                  //     // if (_formKey.currentState!.validate()) {
                  //     //   _formKey.currentState!.save();
                  //     // }
                  //     // if (_pageController.page == 0) {
                  //     //   _pageController.animateToPage(
                  //     //     1,
                  //     //     duration: Duration(milliseconds: 100),
                  //     //     curve: Curves.easeOutCirc,
                  //     //   );
                  //     // }
                  //     switch (_pageController.page) {
                  //       case 0:
                  //         _pageController.animateToPage(
                  //           1,
                  //           duration: Duration(milliseconds: 200),
                  //           curve: Curves.easeOutCirc,
                  //         );
                  //         break;
                  //       case 1:
                  //         Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => NavigationScreen(),
                  //           ),
                  //           (route) => false,
                  //         );
                  //         break;
                  //     }
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 16),
                  //     decoration: BoxDecoration(
                  //       color: kAccentColor,
                  //       borderRadius: BorderRadius.circular(kBorderRadius),
                  //     ),
                  //     child: Center(
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Text(
                  //             "Next",
                  //             style: TextStyle(
                  //               color:
                  //                   Theme.of(context).scaffoldBackgroundColor,
                  //             ),
                  //           ),
                  //           SizedBox(width: 4),
                  //           Icon(
                  //             CupertinoIcons.arrow_right,
                  //             size: 16,
                  //             color: Theme.of(context).scaffoldBackgroundColor,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Form(
              key: _secondFormKey,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    child: TextFormField(
                      key: ValueKey('name'),
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          value!.isNotEmpty ? null : 'Invalid email',
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                      controller: _passwordController,
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
                      key: ValueKey('confirm_password'),
                      controller: _confirmEmailController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .catchError((e) => print(e))
                            .whenComplete(
                              () => Navigator.pop(context),
                            );
                      } catch (e) {
                        print(e);
                      }
                    },
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
                              Icons.check_sharp,
                              size: 16,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Complete Sign Up",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
