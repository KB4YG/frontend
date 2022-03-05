import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/settings.dart';

import '../utilities/beam_locations.dart';

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
          // locationBuilder:
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [HomeLocation()],
          )),
      BeamerDelegate(
        initialPath: routes[1],
        locationBuilder: BeamerLocationBuilder(
          beamLocations: [CountyLocation()],
        ),
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

    // Mark all as inactive initially for accurate web titles
    for (var element in _routerDelegates) {element.active = false;}
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    _navbarIndex = getNavbarIndex(uriString);
    _routerDelegates[_navbarIndex].active = true;
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
      endDrawer: const Settings(),
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
            // Toggle active delegate for accurate web page titles
            _routerDelegates[_navbarIndex].active = false;
            _routerDelegates[index].active = true;

            setState(() => _navbarIndex = index);
            _routerDelegates[_navbarIndex].update(rebuild: false);
          }
        },
      ),
    );
  }
}
