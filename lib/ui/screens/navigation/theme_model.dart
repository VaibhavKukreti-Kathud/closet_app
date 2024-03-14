import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeModel {
  final darkTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlue
    ),
    dialogBackgroundColor: Colors.lightGreen.shade600,
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.teal.shade200,
        textTheme: ButtonTextTheme.normal
    ),
    hintColor: Colors.white,
    dividerColor: Colors.white,
    appBarTheme: AppBarTheme(color: Colors.grey.shade600, systemOverlayStyle: SystemUiOverlayStyle.dark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade700,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.grey.shade100
      ),
      titleMedium: TextStyle(
          color: Colors.grey.shade100
      ),
      bodyLarge: TextStyle(
          color: Colors.grey.shade600
      ),
      bodyMedium: TextStyle(
          color: Colors.grey.shade100
      ),
      // bodySmall: TextStyle(
      //   color: Colors.grey.shade600
      // )
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(background: Colors.blueGrey,brightness: Brightness.dark,),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.grey.shade200,
    hintColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lime
    ),
    dialogBackgroundColor: Colors.brown.shade100,
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.lime.shade700,
        textTheme: ButtonTextTheme.normal
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            color: Colors.black
        ),
        titleMedium: TextStyle(
            color: Colors.black
        ),
        bodyLarge: TextStyle(
            color: Colors.grey.shade300
        ),
        bodyMedium: TextStyle(
            color: Colors.black
        ),
        // bodySmall: TextStyle(
        //     color: Colors.grey.shade200
        // )
    ),
    dividerColor: Colors.black54,
    appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(background: Colors.grey.shade200,brightness: Brightness.light,),
  );
}