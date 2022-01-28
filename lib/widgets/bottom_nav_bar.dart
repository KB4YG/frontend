import 'package:beamer/beamer.dart' show BeamerState, BeamerDelegate;
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';

class BottomNavBar extends StatefulWidget {
  final GlobalKey<BeamerState> beamerKey;
  const BottomNavBar({required this.beamerKey, Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const routes = [
    constants.routeHome,
    constants.routeLocations,
    constants.routeHelp,
    constants.routeAbout
  ];
  late BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  int getCurrentIndex() {
    var uriString = sanitizeUrl(_beamerDelegate.configuration.location!);
    int index = 0;
    for (var route in routes) {
      if (uriString.contains(route)) return index;
      index++;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = getCurrentIndex();
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.blueGrey,
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index != _currentIndex) {
          _beamerDelegate.beamToNamed(routes[index]);
        }
      },
      items: const [
        BottomNavigationBarItem(label: 'Home',    icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Parking', icon: Icon(Icons.directions_car)),
        BottomNavigationBarItem(label: 'Help',    icon: Icon(Icons.help)),
        BottomNavigationBarItem(label: 'About',   icon: Icon(Icons.info)),
      ],
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}
