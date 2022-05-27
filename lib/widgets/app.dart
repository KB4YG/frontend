import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:kb4yg/screens/intro_screen.dart';
import 'package:kb4yg/utilities/beam_locations.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../screens/app_screen.dart';
import '../screens/not_found_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final bool? _isFirstRun;
  late final BeamerDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    final prefs = Provider.of<SharedPreferences>(context, listen: false);

    // Determine whether to display intro/tutorial screen
    _isFirstRun = prefs.getBool(constants.prefIntro);

    // Change router delegate based on whether on web or mobile app.
    // This is so that the mobile app tabs can save nested navigation (e.g.,
    //  return to RecreationAreaScreen() rather than CountyListScreen() when
    //  tapping Locations tab after navigating to another screen).
    // See AppScreen() for more info.
    if (kIsWeb) {
      _routerDelegate = BeamerDelegate(
          initialPath: constants.routeHome,
          notFoundPage: NotFoundScreen.beamPage,
          locationBuilder: BeamerLocationBuilder(beamLocations: [
            HomeLocation(),
            CountyLocation(),
            HelpLocation(),
            AboutLocation(),
          ]));
    } else {
      _routerDelegate = BeamerDelegate(
        initialPath: constants.routeHome,
        locationBuilder: RoutesLocationBuilder(
          routes: {
            '*': (context, state, data) => const AppScreen(),
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme (listening with ChangeNotifierProvider())
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Load intro screen if first time running, else load home screen
    return _isFirstRun == false || kIsWeb
        ? MaterialApp.router(
            title: constants.title,
            themeMode: themeProvider.themeMode, // This is where theme is updated
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            debugShowCheckedModeBanner: false,
            routerDelegate: _routerDelegate,
            routeInformationParser: BeamerParser(),
            backButtonDispatcher:
                BeamerBackButtonDispatcher(delegate: _routerDelegate),
          )
        : const MaterialApp(home: IntroScreen(), debugShowCheckedModeBanner: false,);
  }
}
