import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import 'hover_button.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return const DesktopNavbar();
      } else {
        return const MobileNavbar();
      }
    });
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.green, Colors.lightGreen]),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              child: const Text(
                constants.title,
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
              onPressed: () =>
                  Beamer.of(context).beamToNamed(constants.routeHome),
            ),
            Row(
              children: const <Widget>[
                NavbarButton(
                  route: constants.routeHome,
                  page: constants.pageHome,
                ),
                SizedBox(width: 20),
                NavbarButton(
                  route: constants.routeLocations,
                  page: constants.pageLocations,
                ),
                SizedBox(width: 20),
                NavbarButton(
                  route: constants.routeHelp,
                  page: constants.pageHelp,
                ),
                SizedBox(width: 20),
                NavbarButton(
                  route: constants.routeAbout,
                  page: constants.pageAbout,
                ),
                SizedBox(width: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  const MobileNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.green, Colors.lightGreen]),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(children: <Widget>[
          const Text(
            constants.title,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                NavbarButton(
                  route: constants.routeHome,
                  page: constants.pageHome,
                ),
                SizedBox(width: 10),
                NavbarButton(
                  route: constants.routeLocations,
                  page: constants.pageLocations,
                ),
                SizedBox(width: 10),
                NavbarButton(
                  route: constants.routeHelp,
                  page: constants.pageHelp,
                ),
                SizedBox(width: 10),
                NavbarButton(
                  route: constants.routeAbout,
                  page: constants.pageAbout,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final String route;
  final String page;
  const NavbarButton({Key? key, required this.route, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverButton(
        child: TextButton(
            onPressed: () {
              Beamer.of(context).beamToNamed(route);
            },
            child: Text(
              page,
              style: const TextStyle(color: Colors.white),
            )));
  }
}
