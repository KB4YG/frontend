import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart';
import 'package:kb4yg/widgets/theme_icon_button.dart';

// class Navbar extends StatelessWidget {
//   const Navbar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth > 800) {
//         return const DesktopNavbar();
//       } else {
//         return const MobileNavbar();
//       }
//     });
//   }
// }

// class DesktopNavbar extends StatelessWidget {
//   const DesktopNavbar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [Colors.green, Colors.lightGreen]),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             TextButton(
//               child: const Text(
//                 constants.title,
//                 style: TextStyle(
//                     // fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 30),
//               ),
//               onPressed: () =>
//                   Beamer.of(context).beamToNamed(constants.routeHome),
//             ),
//             Row(
//               children: const <Widget>[
//                 NavbarButton(
//                   route: constants.routeHome,
//                   page: constants.pageHome,
//                 ),
//                 SizedBox(width: 20),
//                 NavbarButton(
//                   route: constants.routeLocations,
//                   page: constants.pageLocations,
//                 ),
//                 SizedBox(width: 20),
//                 NavbarButton(
//                   route: constants.routeHelp,
//                   page: constants.pageHelp,
//                 ),
//                 SizedBox(width: 20),
//                 NavbarButton(
//                   route: constants.routeAbout,
//                   page: constants.pageAbout,
//                 ),
//                 SizedBox(width: 20),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.tertiary
          ]),
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight, width: 5.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.drive_eta, color: Colors.white,
              // Image.asset(
                // 'assets/launcher/kb4yg.png',
                // width: 50,
                // height: 50,
              ),
              label: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              onPressed: () => Beamer.of(context).beamToNamed(routeHome),
            ),
            Row(
              children: const <Widget>[
                SizedBox(width: 20),
                NavbarButton(route: routeHome, page: pageHome),
                SizedBox(width: 20),
                NavbarButton(route: routeLocations, page: pageLocations),
                SizedBox(width: 20),
                NavbarButton(route: routeHelp, page: pageHelp),
                SizedBox(width: 20),
                NavbarButton(route: routeAbout, page: pageAbout),
                SizedBox(width: 20),
                ThemeIconButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [Colors.green, Colors.lightGreen]),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//         child: Column(children: <Widget>[
//           const Text(
//             constants.title,
//             style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 30),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const <Widget>[
//                 NavbarButton(
//                   route: constants.routeHome,
//                   page: constants.pageHome,
//                 ),
//                 SizedBox(width: 10),
//                 NavbarButton(
//                   route: constants.routeLocations,
//                   page: constants.pageLocations,
//                 ),
//                 SizedBox(width: 10),
//                 NavbarButton(
//                   route: constants.routeHelp,
//                   page: constants.pageHelp,
//                 ),
//                 SizedBox(width: 10),
//                 NavbarButton(
//                   route: constants.routeAbout,
//                   page: constants.pageAbout,
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).colorScheme.tertiary
      ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(children: <Widget>[
          const Text(
            title,
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
                NavbarButton(route: routeHome, page: pageHome),
                SizedBox(width: 10),
                NavbarButton(route: routeLocations, page: pageLocations),
                SizedBox(width: 10),
                NavbarButton(route: routeHelp, page: pageHelp),
                SizedBox(width: 10),
                NavbarButton(route: routeAbout, page: pageAbout),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class NavbarButton extends StatefulWidget {
  final String route;
  final String page;
  const NavbarButton({Key? key, required this.route, required this.page})
      : super(key: key);

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  bool _isCurrentPage = false;

  Widget child() => TextButton(
      onPressed: () => Beamer.of(context).beamToNamed(widget.route),
      child: Text(widget.page.toUpperCase(),
          style: const TextStyle(color: Colors.white, letterSpacing: 1.8)));

  @override
  Widget build(BuildContext context) {
    String? uri = Beamer.of(context).configuration.location;
    if (uri != null) _isCurrentPage = uri.contains(widget.route);
    return _isCurrentPage
        ? DecoratedBox(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.white, width: 2),
            )),
            child: child())
        : HoverButton(child: child());
  }
}
