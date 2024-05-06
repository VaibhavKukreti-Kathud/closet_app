import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/services/auth/auth_functions.dart';
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
  AppUser? appUser;
  @override
  void initState() {
    fetchAppUser();
    super.initState();
  }

  void fetchAppUser() async {
    await context.read<UserProvider>().fetchUser();
  }

  // void fetchAppUser() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final AppUser? appUser =
  //         await context.read<AuthFunctions>().fetchAppUser();
  //     if (appUser != null) {
  //       context.read<UserProvider>().setAppUser(appUser);
  //     } else {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => AddUserDetails(),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return context.watch<UserProvider>().appUser != null
        ? NavigationScreen()
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
