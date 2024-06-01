import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:closet_app/ui/screens/authentication/sign_up/sign_up_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/ui/widgets/user_signin_signup_method_tile.dart';
import 'package:closet_app/ui/screens/authentication/sign_up/sign_up_options_screen.dart';

class SignInOptionsScreen extends StatefulWidget {
  const SignInOptionsScreen({super.key});

  @override
  State<SignInOptionsScreen> createState() => _SignInOptionsScreenState();
}

class _SignInOptionsScreenState extends State<SignInOptionsScreen> {
  TextEditingController _mailController = TextEditingController();
  bool mailFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: IntroBranding()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign up',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 32),
                  Text('Email'),
                  SizedBox(height: 4),
                  CustomField(
                    controller: _mailController,
                    hintText: 'xyz@mail.com',
                    onEdit: (v) {
                      setState(() {
                        mailFilled = true;
                      });
                    },
                  ),
                  SizedBox(height: 24),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpDetailsScreen(
                                  email: _mailController.text)));
                    },
                    text: 'Continue',
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          ' Login',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                thickness: 1.0)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                thickness: 1.0)),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  CustomButton(
                    disabled: false,
                    onPressed: () {},
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                    text: 'Sign in with Facebook',
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    disabled: false,
                    onPressed: () {},
                    icon: Image.asset(
                      'images/google_icon.png',
                      height: 28,
                    ),
                    text: 'Sign in with Google',
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    disabled: false,
                    onPressed: () {},
                    icon: Icon(
                      Icons.apple,
                      color: Colors.white,
                    ),
                    text: 'Sign in with Apple',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
