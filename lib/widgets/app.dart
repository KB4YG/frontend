import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:kb4yg/screens/introScreen.dart';
import 'package:kb4yg/utilities/beam_locations.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class App extends StatefulWidget {
  final SharedPreferences prefs;
  const App({required this.prefs, Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final BeamerDelegate routerDelegate;
  late bool? firstTimeDownload;

  @override
  void initState() {
    super.initState();
    var lastCounty = widget.prefs.getString(constants.prefCounty);
    var landingPage = lastCounty == null || kIsWeb
        ? constants.routeHome
        : '${constants.routeLocations}/${sanitizeUrl(lastCounty)}';

    firstTimeDownload = widget.prefs.getBool('firstTimeDownload');

    routerDelegate = BeamerDelegate(
      initialPath: landingPage,
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) {
            final beamerKey = GlobalKey<BeamerState>();
            return Scaffold(
              bottomNavigationBar: BottomNavBar(beamerKey: beamerKey),
              body: Beamer(
                key: beamerKey,
                routerDelegate: BeamerDelegate(
                  locationBuilder: BeamerLocationBuilder(
                    beamLocations: [
                      HomeLocation(),
                      CountyLocation(),
                      HelpLocation(),
                      AboutLocation()
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme (listening with ChangeNotifierProvider())
    final themeProvider = Provider.of<ThemeProvider>(context);

    return (firstTimeDownload == true || firstTimeDownload == null)
        ? MaterialApp(
            home: IntroScreen(
              prefs: widget.prefs,
            ),
          )
        : (MaterialApp.router(
            title: constants.title,
            themeMode: themeProvider.themeMode,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            debugShowCheckedModeBanner: false,
            routerDelegate: routerDelegate,
            routeInformationParser: BeamerParser(),
            backButtonDispatcher:
                BeamerBackButtonDispatcher(delegate: routerDelegate),
          ));
  }
}
