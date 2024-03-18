import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/auth/auth_functions.dart' as af;
import 'package:closet_app/ui/screens/authentication/additional_info/add_user_details.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    af.AuthProvider authProvider = af.AuthProvider(
        firebaseAuth: FirebaseAuth.instance,
        prefs: context.read<SharedPreferences>());

    return NavigationScreen();
  }
}
