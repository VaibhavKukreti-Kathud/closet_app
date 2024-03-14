import 'package:closet_app/app.dart';
import 'package:closet_app/firebase_options.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          primary: kAccentColor,
          seedColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            )
          ],
          child: Consumer(
            builder: (context, UserProvider userProvider, child) {
              return userProvider.isSignedIn
                  ? const App()
                  : const SignInScreen();
            },
          )),
    );
  }
}
