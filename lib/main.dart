import 'dart:developer';
import 'package:closet_app/firebase_options.dart';
import 'package:closet_app/services/auth/auth_functions.dart' as af;
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:closet_app/ui/screens/navigation/theme_manager.dart';
import 'package:closet_app/ui/screens/navigation/theme_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(MyApp(
  //   prefs: await SharedPreferences.getInstance(),
  // ));
  runApp(MyApp(
    prefs: await SharedPreferences.getInstance(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    af.AuthProvider authProvider = af.AuthProvider(
      firebaseAuth: FirebaseAuth.instance,
      prefs: prefs,
    );
    return MultiProvider(
        providers: [
          StreamProvider<User?>.value(
              value: FirebaseAuth.instance.authStateChanges(),
              initialData: null),
          Provider<SharedPreferences>.value(value: prefs),
          Provider<af.AuthProvider>.value(value: authProvider),
          ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ],
        child:
            Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.getTheme(),
            debugShowCheckedModeBanner: false,
            home: const AuthGate(),
          );
        }));
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);
    bool loggedIn = firebaseUser != null;
    log('User is logged in: $loggedIn');
    return Scaffold(
      backgroundColor: Colors.white,
      body: loggedIn ? const NavigationScreen() : const SignInScreen(),
    );
  }
}
