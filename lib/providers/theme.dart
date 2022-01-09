import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

bool isBright() => SchedulerBinding.instance!.window.platformBrightness == Brightness.light;

class ThemeProvider extends ChangeNotifier {
  bool _isInitialized = false;
  ThemeMode themeMode = isBright() ? ThemeMode.light : ThemeMode.dark;
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
  // TODO: add themes
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
