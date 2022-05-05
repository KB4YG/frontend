import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'logo.dart';

/// Navigation drawer for web browser on mobile phone.
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = Beamer.of(context).configuration.location;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Logo(),
                ),
                Text('Page Navigation', textScaleFactor: 1.4),
              ],
            ),
          ),
          ListTile(
            selected: routeHome == currentRoute,
            title: const Text(pageHome),
            onTap: () => Beamer.of(context).beamToNamed(routeHome),
          ),
          ListTile(
            selected: currentRoute!.contains(routeLocations),
            title: const Text(pageLocations),
            onTap: () => Beamer.of(context).beamToNamed(routeLocations),
          ),
          ListTile(
            selected: routeHelp == currentRoute,
            title: const Text(pageHelp),
            onTap: () => Beamer.of(context).beamToNamed(routeHelp),
          ),
          ListTile(
            selected: routeAbout == currentRoute,
            title: const Text(pageAbout),
            onTap: () => Beamer.of(context).beamToNamed(routeAbout),
          )
        ],
      ),
    );
  }
}
