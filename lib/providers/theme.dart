import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  late ThemeMode themeMode;

  bool get isDark => themeMode == ThemeMode.dark;

  // Constructor
  ThemeProvider({required this.prefs}) {
    if (kDebugMode) print('Initialized Theme Provider');
    // Get dark theme preference from shared prefs
    final darkPref = prefs.getBool(constants.prefDark);
    // Use dark theme if user selected it before or system theme is dark
    // (darkPref == null is needed if set light theme as preference)
    themeMode = darkPref == true ||
            (darkPref == null &&
                WidgetsBinding.instance!.window.platformBrightness ==
                    Brightness.dark)
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  /// Sets theme to dark if [isDark] is true, light if false, or opposite of current
  /// theme if left null. Notifies listeners of [ThemeProvider] to rebuild widget tree.
  void toggleTheme(bool? isDark) {
    isDark = isDark ?? !this.isDark; // If isDark parameter is null check mode
    if (kDebugMode) print('Toggled Theme to ${isDark ? 'Dark' : 'Light'}');
    prefs.setBool(constants.prefDark, isDark);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  @override
  String toString() => 'ThemeProvider(themeMode: $themeMode, isDark: $isDark}';
}

class Themes {
  static const textTheme = TextTheme(
    headline6: TextStyle(fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0, height: 1.75),
  );

  static final lightTheme = ThemeData(
      fontFamily: 'OpenSans',
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xfff4f7f5),
      primarySwatch: Colors.green,
      cardColor: const Color(0xfffefefe),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.green.shade600,
            primary: Colors.green.shade50,
            side: BorderSide(color: Colors.green.shade100)),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.green,
        unselectedLabelColor: Colors.blueGrey
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
          .copyWith(tertiary: Colors.lightGreen));

  static final darkTheme = ThemeData(
      fontFamily: 'OpenSans',
      textTheme: textTheme,
      indicatorColor: Colors.lightBlue.shade300,
      tabBarTheme: const TabBarTheme(unselectedLabelColor: Colors.white60),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.blueGrey.shade50,
            primary: Colors.blueGrey.shade700,
            side: BorderSide(color: Colors.blueGrey.shade600)),
      ),
      colorScheme: ColorScheme.fromSwatch(
              brightness: Brightness.dark,
              primarySwatch: kIsWeb ? Colors.blueGrey : Colors.lightBlue)
          .copyWith(
        tertiary: Colors.blueGrey.shade900,
        secondary: Colors.lightBlue.shade300,
      ));
}
