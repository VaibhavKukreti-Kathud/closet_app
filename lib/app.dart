import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/screens/authentication/additional_info/add_user_details.dart';
import 'package:closet_app/ui/screens/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    context.read<UserProvider>().getCurrentAppUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      bool dataExists = userProvider.currentAppUser != null;
      return dataExists ? NavigationScreen() : AddUserDetailsScreen();
    });
  }
}
