import 'package:flutter/material.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/utilities/router.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/providers/theme.dart';
import 'package:provider/provider.dart' show Provider, ChangeNotifierProvider;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;


class App extends StatelessWidget {
  final SharedPreferences prefs;
  final Counties counties;
  late final String landingPage;

  App({Key? key, required this.prefs, required this.counties}) : super(key: key) {
    final lastCounty = prefs.getString(constants.prefCounty);
    landingPage = lastCounty == null ?
      constants.routeHome : '${constants.routeParking}/${lastCounty.toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(prefs: prefs),
    builder: (context, _) {
      // Get current theme (listening with ChangeNotifierProvider())
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        title: constants.title,
        themeMode: themeProvider.themeMode,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        initialRoute: landingPage,
        onGenerateRoute: (settings) {
          return routeHandler(settings, counties, prefs);
        });
    }
  );
}
