import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:kb4yg/widgets/app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Wait for widget initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Remove "#" from URL
  Beamer.setPathUrlStrategy();

  // Get preferences of user (used for theme and county parking info)
  final prefs = await SharedPreferences.getInstance();

  // Run application
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider(prefs: prefs)),
        Provider<SharedPreferences>(create: (context) => prefs),
        Provider<BackendProvider>(create: (context) => BackendProvider())
      ],
      // child: MyApp()),
      child: App(prefs: prefs))
  );
}
