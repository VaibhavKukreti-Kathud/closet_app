import 'package:flutter/material.dart';
import 'package:closet_app/ui/widgets/user_signin_signup_method_tile.dart';
import 'package:closet_app/ui/screens/authentication/sign_up/sign_up_options_screen.dart';

class SignInOptionsScreen extends StatefulWidget {
  const SignInOptionsScreen({super.key});

  @override
  State<SignInOptionsScreen> createState() => _SignInOptionsScreenState();
}

class _SignInOptionsScreenState extends State<SignInOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text('Welcome Back to My Closet App !',
                    style: TextStyle(
                        fontSize: 54.0,
                        fontFamily: 'Philosopher'
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    UserLoginSignupMethodTile(organisationIcon: Icons.apple, organisationName: 'Apple', methodName: 'Sign In',organisationIconColor: Colors.black,isGoogle: false,),
                    Spacer(),
                    UserLoginSignupMethodTile(organisationIcon: Icons.facebook, organisationName: 'Facebook', methodName: 'Sign In',organisationIconColor: Colors.blue.shade800,isGoogle: false,),
                    Spacer(),
                    UserLoginSignupMethodTile(organisationIcon: Icons.report_gmailerrorred, organisationName: 'Google', methodName: 'Sign In',organisationIconColor: Colors.red,isGoogle: true,),
                    Divider(color: Colors.grey.shade400,thickness: 1.0),
                    Spacer(),
                    UserLoginSignupMethodTile(organisationIcon: Icons.email_outlined, organisationName: 'your Email', methodName: 'Sign In',organisationIconColor: Colors.black,isGoogle: false,),
                    Spacer(flex: 7),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpOptionsScreen()));
                        },
                        child: Text('New User ? Click here to sign up.',style: TextStyle(fontSize: 16.0,color: Colors.black),)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}