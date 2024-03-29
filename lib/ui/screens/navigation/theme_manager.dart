import 'package:flutter/material.dart';
import 'storage_manager.dart';
import 'theme_model.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = ThemeModel().lightTheme;
  ThemeData getTheme() => _themeData;
  ThemeModel themeModel = ThemeModel();

  ThemeNotifier() {
    // themeModel = ThemeModel();
    StorageManager.readData('themeMode').then((value) {
      // print('value read from storage: ${value.toString()}');
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = themeModel.lightTheme;
      } else {
        // print('setting dark theme');
        _themeData = themeModel.darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = themeModel.darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = themeModel.lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}