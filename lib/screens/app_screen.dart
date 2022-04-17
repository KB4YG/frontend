import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

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
  int _navbarIndex = 0;

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
    // Using multiple Beamers and a BeamerDelegate for each allows us to save
    // nested state (e.g., user can return to county details rather than list)
    _routerDelegates = [
      BeamerDelegate(
          initialPath: routes[0],
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
    for (var element in _routerDelegates) {
      element.active = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    // Toggle active beamer delegate TODO: fix for web or don't
    _routerDelegates[_navbarIndex].active = false;
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
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [
              Beamer(routerDelegate: _routerDelegates[0]),
              Beamer(routerDelegate: _routerDelegates[1]),
              Beamer(routerDelegate: _routerDelegates[2]),
              Beamer(routerDelegate: _routerDelegates[3])
            ],
          ),
          bottomNavigationBar: Material(
            type: MaterialType.card,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.blueGrey,
              tabs: const [
                Tab(
                  text: constants.pageHome,
                  icon: Icon(Icons.home),
                  iconMargin: EdgeInsets.only(bottom: 4.0),
                ),
                Tab(
                  text: constants.pageLocations,
                  icon: Icon(Icons.directions_car),
                  iconMargin: EdgeInsets.only(bottom: 4.0),
                ),
                Tab(
                  text: constants.pageHelp,
                  icon: Icon(Icons.help),
                  iconMargin: EdgeInsets.only(bottom: 4.0),
                ),
                Tab(
                  text: constants.pageAbout,
                  icon: Icon(Icons.info),
                  iconMargin: EdgeInsets.only(bottom: 4.0),
                )
              ],
            ),
          ),
        ));
  }
}
