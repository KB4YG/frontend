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
  static final lightTheme = ThemeData(
    fontFamily: 'OpenSans',
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: const Color(0xFFF6F7F9),
    primaryColor: Colors.white,
    // colorScheme: const ColorScheme.light(),
    // iconTheme: const IconThemeData(color: Colors.lightGreen, opacity: 0.8),
  );

  static final darkTheme = ThemeData.dark(
      // scaffoldBackgroundColor: Colors.grey.shade900,
      // primaryColor: Colors.black,
      // colorScheme: const ColorScheme.dark(),
      // iconTheme: const IconThemeData(color: Colors.lightGreen, opacity: 0.8),
      );
}
