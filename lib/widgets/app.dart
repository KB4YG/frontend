import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:kb4yg/screens/intro_screen.dart';
import 'package:kb4yg/utilities/beam_locations.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

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

    _routerDelegate = BeamerDelegate(
      initialPath: constants.routeHome,
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) => const AppScreen(),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme (listening with ChangeNotifierProvider())
    final themeProvider = Provider.of<ThemeProvider>(context);

    return _isFirstRun == false || kIsWeb
        ? MaterialApp.router(
            title: constants.title,
            themeMode: themeProvider.themeMode,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            debugShowCheckedModeBanner: false,
            routerDelegate: _routerDelegate,
            routeInformationParser: BeamerParser(),
            backButtonDispatcher:
                BeamerBackButtonDispatcher(delegate: _routerDelegate),
          )
        : const MaterialApp(
            home: IntroScreen(),
          );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  static const routes = [
    constants.routeHome,
    constants.routeLocations,
    constants.routeHelp,
    constants.routeAbout
  ];
  late final List<BeamerDelegate> _routerDelegates;
  late int _navbarIndex;
  // late int _routerIndex;

  @override
  void initState() {
    super.initState();
    // TODO: re-add landing page feature
    // final prefs = Provider.of<SharedPreferences>(context, listen: false);

    // Determine landing page (home or county screen)
    // var lastCounty = prefs.getString(constants.prefCounty);
    // var landingPage = lastCounty == null || kIsWeb
    //     ? constants.routeHome
    //     : '${constants.routeLocations}/${sanitizeUrl(lastCounty)}';

    // Initialize router delegates (widgets that handle routing)
    _routerDelegates = [
      BeamerDelegate(
          initialPath: routes[0],
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [HomeLocation()],
          )),
      BeamerDelegate(
        initialPath: routes[1],
        locationBuilder: (routeInformation, _) {
          if (routeInformation.location!.contains('locations')) {
            return CountyLocation(routeInformation);
          }
          return NotFound(path: routeInformation.location!);
        },
      ),
      BeamerDelegate(
          initialPath: routes[2],
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [HelpLocation()],
          )),
      BeamerDelegate(
          initialPath: routes[3],
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [AboutLocation()],
          )),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    _navbarIndex = getNavbarIndex(uriString);
  }

  int getNavbarIndex(String uri) {
    int index = 0;
    for (var route in routes) {
      if (uri.contains(route)) return index;
      index++;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _navbarIndex,
        children: [
          Beamer(routerDelegate: _routerDelegates[0]),
          Beamer(routerDelegate: _routerDelegates[1]),
          Beamer(routerDelegate: _routerDelegates[2]),
          Beamer(routerDelegate: _routerDelegates[3]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _navbarIndex,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Parking', icon: Icon(Icons.drive_eta)),
          BottomNavigationBarItem(label: 'Help', icon: Icon(Icons.help)),
          BottomNavigationBarItem(label: 'About', icon: Icon(Icons.info)),
        ],
        onTap: (index) {
          if (index != _navbarIndex) {
            setState(() => _navbarIndex = index);
            _routerDelegates[_navbarIndex].update(rebuild: false);
          }
        },
      ),
    );
  }
}
