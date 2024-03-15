import 'package:closet_app/app.dart';
import 'package:closet_app/firebase_options.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:closet_app/ui/screens/navigation/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            ),
            Provider.value(value: (context) => FirebaseAuth.instance),
          ],
          child: Consumer(
            builder: (context, UserProvider userProvider, child) {
              return FirebaseAuth.instance.currentUser != null
                  ? const App()
                  : const SignInScreen();
            },
          )),
    );
  }
}
