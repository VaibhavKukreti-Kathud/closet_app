import 'dart:developer';
import 'dart:ui';

import 'package:closet_app/constants.dart';
import 'package:closet_app/main.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/snackbar.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:closet_app/services/auth/auth_functions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  bool mailFilled = false;
  bool passwordFilled = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: SafeArea(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Spacer(),
    //           Row(
    //             children: [
    //               Expanded(
    //                 child: SizedBox(
    //                   width: double.maxFinite,
    //                   height: 32,
    //                   child: FlutterLogo(
    //                     style: FlutterLogoStyle.horizontal,
    //                   ),
    //                 ),
    //               ),
    //               Spacer(flex: 2),
    //             ],
    //           ),
    //           Spacer(flex: 4),
    //           Form(
    //             key: _formKey,
    //             child: Column(
    //               children: <Widget>[
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(kBorderRadius),
    //                   child: TextFormField(
    //                     focusNode: _emailFocusNode,
    //                     key: ValueKey('email'),
    //                     keyboardType: TextInputType.emailAddress,
    //                     controller: _emailController,
    //                     validator: (value) => EmailValidator.validate(value!)
    //                         ? null
    //                         : 'Invalid email',
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(
    //                           horizontal: 24, vertical: 12),
    //                       labelText: 'Email',
    //                       labelStyle: TextStyle(
    //                         fontSize: 16.0,
    //                       ),
    //                       filled: true,
    //                       fillColor: Colors.grey[100],
    //                       border: InputBorder.none,
    //                       enabledBorder: InputBorder.none,
    //                       focusedBorder: InputBorder.none,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 8),
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(kBorderRadius),
    //                   child: TextFormField(
    //                     focusNode: _passwordFocusNode,
    //                     key: ValueKey('password'),
    //                     obscureText: true,
    //                     controller: _passwordController,
    //                     validator: (value) =>
    //                         value!.isEmpty ? 'Password cannot be empty' : null,
    //                     decoration: InputDecoration(
    //                         labelText: 'Password',
    //                         filled: true,
    //                         contentPadding: EdgeInsets.symmetric(
    //                             horizontal: 24, vertical: 12),
    //                         fillColor: Colors.grey[100],
    //                         labelStyle: TextStyle(
    //                           fontSize: 16.0,
    //                         ),
    //                         border: InputBorder.none,
    //                         enabledBorder: InputBorder.none,
    //                         focusedBorder: InputBorder.none),
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.centerRight,
    //                   child: TextButton(
    //                     onPressed: () {},
    //                     child: Text('Forgot Password?'),
    //                   ),
    //                 ),
    //                 SizedBox(height: 16),
    //                 ZoomTapAnimation(
    //                   onTap: () {
    //                     if (_formKey.currentState!.validate()) {
    //                       _formKey.currentState!.save();
    //                       try {
    //                         context
    //                             .read<UserProvider>()
    //                             .signInWithMailAndPassword(
    //                               email: _email,
    //                               password: _password,
    //                             )
    //                             .whenComplete(() => Navigator.pushReplacement(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         NavigationScreen())))
    //                             .onError(
    //                           (error, stackTrace) {
    //                             throw error!;
    //                           },
    //                         );
    //                       } catch (e) {
    //                         log(e.toString());
    //                       }
    //                     }
    //                   },
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(vertical: 16),
    //                     decoration: BoxDecoration(
    //                       color: kAccentColor,
    //                       borderRadius: BorderRadius.circular(kBorderRadius),
    //                     ),
    //                     child: Center(
    //                       child: Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           Icon(
    //                             Icons.lock_outline,
    //                             size: 16,
    //                             color:
    //                                 Theme.of(context).scaffoldBackgroundColor,
    //                           ),
    //                           SizedBox(width: 4),
    //                           Text(
    //                             "Sign in",
    //                             style: TextStyle(
    //                               color:
    //                                   Theme.of(context).scaffoldBackgroundColor,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 10),
    //                 ZoomTapAnimation(
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(vertical: 16),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(color: kAccentColor),
    //                       borderRadius: BorderRadius.circular(kBorderRadius),
    //                     ),
    //                     child: Center(
    //                       child: Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           Icon(
    //                             Icons.person_outline_rounded,
    //                             size: 16,
    //                             color: kAccentColor,
    //                           ),
    //                           SizedBox(width: 4),
    //                           Text(
    //                             "Create an account",
    //                             style: TextStyle(color: kAccentColor),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   onTap: () {
    //                     Navigator.of(context).push(
    //                       MaterialPageRoute(
    //                         builder: (context) => SignUpScreen(),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //                 SizedBox(height: 4),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 32, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(
                  color: Color.fromARGB(255, 99, 185, 255), fontSize: 40),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 32, left: 32),
            child: Column(
              children: [
                Spacer(),
                CustomField(
                  controller: _mailController,
                  hintText: 'Email',
                  onEdit: (v) {
                    setState(() {
                      mailFilled = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscured: true,
                    onEdit: (v) {
                      setState(() {
                        v.length >= 6
                            ? passwordFilled = true
                            : passwordFilled = false;
                      });
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Scaffold())),
                    child: Text(
                      'Forgot passoword?',
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  disabled: !mailFilled || !passwordFilled || loading,
                  onPressed: !mailFilled || !passwordFilled || loading
                      ? () {}
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          if (_mailController.text == '') {
                            showSnackbar(
                                context, 'Please enter your mail address');
                          } else if (_passwordController.text == '') {
                            showSnackbar(context, 'Please enter the password');
                          } else {
                            String res = await AuthFunctions(
                                    firebaseAuth: FirebaseAuth.instance,
                                    prefs: Provider.of<SharedPreferences>(
                                        context,
                                        listen: false)!)
                                .handleSignIn(_mailController.text,
                                    _passwordController.text, null, null)
                                .onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              return showSnackbar(context, error.toString());
                            });
                            res != FUNCTION_SUCCESSFUL
                                ? showSnackbar(context, res)
                                : () {};
                          }
                        },
                  text: 'Login',
                ),
                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'If you dont have an account,',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff4c505b),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: const Text(
                      'click here',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xff4c505b),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 15),
              ],
            ),
          ),
          loading
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    color: loading ? Colors.white30 : Colors.transparent,
                  ),
                )
              : SizedBox(),
          loading ? SafeArea(child: LinearProgressIndicator()) : SizedBox(),
          loading
              ? Center(
                  child: Text('Hold on!'),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.onPressed,
      this.text = '',
      this.icon,
      this.disabled = false});

  final Function() onPressed;
  final String text;
  bool disabled;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? () {} : onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 56,
        decoration: BoxDecoration(
            boxShadow: disabled
                ? []
                : [
                    BoxShadow(
                      blurRadius: 30,
                      spreadRadius: -20,
                      offset: Offset(0, 20),
                      color: kButtonShadowColor,
                    )
                  ],
            color: disabled ? kDiabledButtonColor : kButtonPColor,
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width - 64,
        child: Center(
            child: icon ??
                Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
      ),
    );
  }
}

class CustomField extends StatefulWidget {
  CustomField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscured = false,
    this.onTap,
    this.onEdit,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscured;
  final String hintText;
  var onTap;
  var onEdit;
  Icon? prefixIcon;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    bool showing = widget.obscured;

    var kBorderRadius2 = 10.0;
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: kBGFieldColor,
          borderRadius: BorderRadius.circular(kBorderRadius2)),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                obscureText: showing,
                onChanged: widget.onEdit,
                onTap: widget.onTap,
                decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
                    hintText: widget.hintText,

                    // fillColor: Colors.red,
                    // filled: true,
                    hintStyle: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(0.35)),
                    contentPadding: EdgeInsets.symmetric(),
                    border: InputBorder.none),
              ),
            ),
            widget.obscured
                ? SizedBox(
                    width: 30,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          showing = !showing;
                        });
                      },
                      icon: Icon(
                        !showing
                            ? Icons.visibility_off_rounded
                            : Icons.visibility,
                        color: Colors.black54,
                        size: 17,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
