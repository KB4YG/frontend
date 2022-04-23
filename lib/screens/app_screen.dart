import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import '../utilities/beam_locations.dart';

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

class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final void Function()? onChangeTab;
  const CustomTabBar({Key? key, required this.controller, this.onChangeTab})
      : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  TabController get _tabController => widget.controller;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(onChangeTab);
  }

  void onChangeTab() {
    setState(() => _tabIndex = _tabController.index);
    if (widget.onChangeTab != null) widget.onChangeTab!();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.controller,
      indicatorColor: Colors.transparent,
      tabs: [
        Tab(
          text: constants.pageHome,
          icon: _tabIndex == 0
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageLocations,
          icon: _tabIndex == 1
              ? const Icon(Icons.directions_car)
              : const Icon(Icons.directions_car_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageHelp,
          icon: _tabIndex == 2
              ? const Icon(Icons.help_outlined)
              : const Icon(Icons.help_outline),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageAbout,
          icon: _tabIndex == 3
              ? const Icon(Icons.info)
              : const Icon(Icons.info_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        )
      ],

    );
  }
}
