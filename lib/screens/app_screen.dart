import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import '../utilities/beam_locations.dart';
import '../widgets/custom_tab_bar.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  static const routes = [
    constants.routeHome,
    constants.routeLocations,
    constants.routeHelp,
    constants.routeAbout
  ];
  late final TabController _tabController;
  late final List<BeamerDelegate> _routerDelegates;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            Beamer(routerDelegate: _routerDelegates[0]),
            Beamer(routerDelegate: _routerDelegates[1]),
            Beamer(routerDelegate: _routerDelegates[2]),
            Beamer(routerDelegate: _routerDelegates[3])
          ],
        ),
        bottomNavigationBar: CustomTabBar(
          controller: _tabController,
          onChangeTab: () {
            _routerDelegates[_tabController.previousIndex].active = false;
            _routerDelegates[_tabController.index].active = true;
          },
        ));
  }
}
