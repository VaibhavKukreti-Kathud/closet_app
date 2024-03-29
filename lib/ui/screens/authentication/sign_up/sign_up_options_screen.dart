import 'package:closet_app/ui/screens/authentication/sign_up/select_country_screen.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/ui/widgets/user_signin_signup_method_tile.dart';

class SignUpOptionsScreen extends StatefulWidget {
  const SignUpOptionsScreen({super.key});

  @override
  State<SignUpOptionsScreen> createState() => _SignUpOptionsScreenState();
}

class _SignUpOptionsScreenState extends State<SignUpOptionsScreen> {
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
                  child: Text('Welcome to My Closet App !',
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
                    UserLoginSignupMethodTile(organisationIcon: Icons.apple, organisationName: 'Apple', methodName: 'Sign Up',organisationIconColor: Colors.black,isGoogle: false,),
                    Spacer(),
                    UserLoginSignupMethodTile(organisationIcon: Icons.facebook, organisationName: 'Facebook', methodName: 'Sign Up',organisationIconColor: Colors.blue.shade800,isGoogle: false,),
                    Spacer(),
                    UserLoginSignupMethodTile(organisationIcon: Icons.report_gmailerrorred, organisationName: 'Google', methodName: 'Sign Up',organisationIconColor: Colors.red,isGoogle: true,),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade400,thickness: 1.0)),
                        Text(' OR ',style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.w600),),
                        Expanded(child: Divider(color: Colors.grey.shade400,thickness: 1.0)),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCountryScreen()));
                      },
                        child: UserLoginSignupMethodTile(organisationIcon: Icons.email_outlined, organisationName: 'your Email', methodName: 'Sign Up',organisationIconColor: Colors.black,isGoogle: false,)
                    ),
                    Spacer(flex: 7)
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