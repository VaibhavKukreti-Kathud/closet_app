import 'dart:ui';
import 'package:closet_app/constants.dart';
import 'package:closet_app/services/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 16, left: 16),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: IntroBranding(),
                ),
                SizedBox(height: 64),
                Text('Login',
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
                  height: 16,
                ),
                CustomButton(
                  disabled: !mailFilled || !passwordFilled || loading,
                  onPressed: !mailFilled || !passwordFilled || loading
                      ? () {}
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          String res = await AuthFunctions(
                                  firebaseAuth: FirebaseAuth.instance,
                                  prefs: Provider.of<SharedPreferences>(context,
                                      listen: false))
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
                        },
                  text: 'Sign in',
                ),
                SizedBox(height: 12),
                SecondaryCustomButton(
                  disabled: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Create an account',
                ),
                SizedBox(height: 32),
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

class IntroBranding extends StatelessWidget {
  const IntroBranding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: 'intro_branding',
              child: SvgPicture.asset(
                'assets/logo_black.svg',
                fit: BoxFit.cover,
                height: 85,
              ),
            ),
            Text('Adding moments to Styles',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w100)),
          ],
        ),
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
          height: 48,
          decoration: BoxDecoration(
              boxShadow: disabled
                  ? []
                  : [
                      // BoxShadow(
                      //   blurRadius: 30,
                      //   spreadRadius: -20,
                      //   offset: Offset(0, 20),
                      //   color: kButtonShadowColor,
                      // )
                    ],
              color: disabled
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(kBorderRadius)),
          child: Center(
            child: icon == null
                ? Text(
                    text,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      SizedBox(width: 4),
                      Text(
                        text,
                      )
                    ],
                  ),
          )),
    );
  }
}

class CustomField extends StatefulWidget {
  CustomField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.obscured = false,
    this.onTap,
    this.onEdit,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscured;
  final String hintText;
  final FocusNode? focusNode;
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
          border:
              Border.all(color: Color.fromARGB(255, 182, 182, 182), width: 1),
          color: kBGFieldColor,
          borderRadius: BorderRadius.circular(kBorderRadius2)),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: widget.focusNode,
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

class SecondaryCustomButton extends StatelessWidget {
  SecondaryCustomButton(
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
        height: 48,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color(0xffBF9370), width: 1),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Center(
            child: icon ??
                Text(
                  text,
                  style: TextStyle(color: Color(0xffBF9370)),
                )),
      ),
    );
  }
}
