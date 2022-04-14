import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  late ThemeMode themeMode;
  bool get isDark => themeMode == ThemeMode.dark;

  // Constructor
  ThemeProvider({required this.prefs}) {
    if (kDebugMode) print('Initialized Theme Provider');
    final darkPref = prefs.getBool(constants.prefDark);
    // Use dark theme if user selected preference or system theme is dark
    themeMode = darkPref == true ||
            WidgetsBinding.instance!.window.platformBrightness ==
                Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void toggleTheme(bool? isDark) {
    isDark = isDark ?? !this.isDark; // If parameter left null check mode
    if (kDebugMode) print('Toggled Theme to ${isDark ? 'Dark' : 'Light'}');
    prefs.setBool(constants.prefDark, isDark);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  @override
  String toString() => 'ThemeProvider(themeMode: $themeMode, isDark: $isDark}';
}

class Themes {
  // TODO: add themes
  static const textTheme = TextTheme(
    headline6: TextStyle(fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0, height: 1.75),
  );

  static final lightTheme = ThemeData(
      fontFamily: 'OpenSans',
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFFF6F7F9),
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
          .copyWith(tertiary: Colors.lightGreen));

  static final darkTheme = ThemeData(
      fontFamily: 'OpenSans',
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSwatch(
              brightness: Brightness.dark, primarySwatch: Colors.blue)
          .copyWith(
              tertiary: Colors.grey.shade800, secondary: Colors.lightBlue));
}
