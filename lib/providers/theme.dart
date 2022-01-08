import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

class ThemeProvider extends ChangeNotifier {
  bool _isInitialized = false;
  ThemeMode themeMode = ThemeMode.light;
  bool get isDark => themeMode == ThemeMode.dark;

  Future<void> initTheme({SharedPreferences? prefs}) async {
    if (!_isInitialized) {
      print('Initialized Theme Provider');
      prefs ??= await SharedPreferences.getInstance();
      final bool? isDark = prefs.getBool(constants.prefDark);
      themeMode = isDark == true ? ThemeMode.dark : ThemeMode.light;
      _isInitialized = true;
    }
  }

  void toggleTheme(bool isDark, {SharedPreferences? prefs}) async {
    print('Toggled Theme to ${ isDark ? 'Dark' : 'Light' }');
    prefs ??= await SharedPreferences.getInstance();
    prefs.setBool(constants.prefDark, isDark);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Themes {
  static final lightTheme = ThemeData(
    // primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.whit  e,
    // colorScheme: const ColorScheme.light(),
    // iconTheme: const IconThemeData(color: Colors.lightGreen, opacity: 0.8),
  );

  static final darkTheme = ThemeData.dark();
  // ThemeData(
  //   scaffoldBackgroundColor: Colors.grey.shade900,
  //   primaryColor: Colors.black,
  //   colorScheme: const ColorScheme.dark(),
  //   iconTheme: const IconThemeData(color: Colors.lightGreen, opacity: 0.8),
  // );
}
