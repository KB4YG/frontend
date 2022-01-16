import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'package:kb4yg/utilities/constants.dart' as constants;


class ThemeProvider extends ChangeNotifier {
  // Member variables
  final SharedPreferences prefs;
  late ThemeMode themeMode;
  bool get isDark => themeMode == ThemeMode.dark;

  // Constructor
  ThemeProvider({required this.prefs}) {
    print('Initialized Theme Provider');
    final darkPref = prefs.getBool(constants.prefDark);
    themeMode = darkPref == true ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isDark) async {
    print('Toggled Theme to ${isDark ? 'Dark' : 'Light'}');
    prefs.setBool(constants.prefDark, isDark);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  @override
  String toString() => 'ThemeProvider(themeMode: $themeMode, isDark: $isDark}';
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
