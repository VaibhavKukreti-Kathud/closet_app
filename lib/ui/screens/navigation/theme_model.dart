import 'package:closet_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel {
  final darkTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.lightBlue),
    dialogBackgroundColor: Colors.lightGreen.shade600,
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.teal.shade200, textTheme: ButtonTextTheme.normal),
    hintColor: Colors.white,
    dividerColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.grey.shade600,
        systemOverlayStyle: SystemUiOverlayStyle.dark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade700,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.grey.shade100),
      titleMedium: TextStyle(color: Colors.grey.shade100),
      bodyLarge: TextStyle(color: Colors.grey.shade600),
      bodyMedium: TextStyle(color: Colors.grey.shade100),
      // bodySmall: TextStyle(
      //   color: Colors.grey.shade600
      // )
    ),
    iconTheme: IconThemeData(color: Colors.white),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(
      background: Colors.blueGrey,
      brightness: Brightness.dark,
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    dialogBackgroundColor: Color.fromARGB(255, 244, 228, 218),
    buttonTheme: ButtonThemeData(
        buttonColor: kSecondaryColor, textTheme: ButtonTextTheme.normal),
    textTheme: GoogleFonts.poppinsTextTheme(),
    dividerColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: kPrimaryColor,
      surfaceTintColor: kSecondaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kPrimaryColor,
      selectedItemColor: kSecondaryColor,
      unselectedItemColor: Colors.black.withOpacity(0.5),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      background: Colors.white,
      brightness: Brightness.light,
    ),
  );
}
