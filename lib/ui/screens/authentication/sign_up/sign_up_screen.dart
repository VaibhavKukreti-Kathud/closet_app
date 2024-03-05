import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final PageController _pageController = PageController();
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: LinearProgressIndicator(
            value: progress,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              switch (value) {
                case 0:
                  progress = 0;
                  break;
                case 1:
                  progress = 0.5;
                  break;
                default:
                  progress = 0;
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
                      onSaved: (value) => _email = value!,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be empty' : null,
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
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      // }
                      // if (_pageController.page == 0) {
                      //   _pageController.animateToPage(
                      //     1,
                      //     duration: Duration(milliseconds: 100),
                      //     curve: Curves.easeOutCirc,
                      //   );
                      // }
                      switch (_pageController.page) {
                        case 0:
                          _pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeOutCirc,
                          );
                          break;
                        case 1:
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NavigationScreen(),
                            ),
                            (route) => false,
                          );
                          break;
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
                            Text(
                              "Next",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 16,
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'Invalid email',
                      onSaved: (value) => _email = value!,
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
                      onSaved: (value) => _email = value!,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be empty' : null,
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
                      if (_secondFormKey.currentState!.validate()) {
                        _secondFormKey.currentState!.save();
                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NavigationScreen(),
                        ),
                        (route) => false,
                      );
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
