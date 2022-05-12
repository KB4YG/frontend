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

  // Remove "#" from URL (makes URL look more native to web)
  Beamer.setPathUrlStrategy();

  // Get preferences of user (used for theme and mobile intro screen)
  final prefs = await SharedPreferences.getInstance();

  // Run application (lib/widgets/app.dart)
  // MultiProvider allows us to reference the objects passed to it throughout the widget tree.
  // For instance, we can write "Provider.of<BackendProvider>(context, listen: false);"
  // (or use the method "BackendProvider.of(context);" for brevity)
  // to access the single instance of BackendProvider() created here.
  return runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(prefs: prefs)),
      Provider<SharedPreferences>(create: (context) => prefs),
      Provider<BackendProvider>(create: (context) => BackendProvider())
    ], child: const App()),
  );
}
