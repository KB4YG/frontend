// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart' show BuildContext, RouteSettings, MaterialPageRoute;
// import 'package:kb4yg/models/counties.dart';
// import 'package:kb4yg/screens/about.dart';
// import 'package:kb4yg/screens/help.dart';
// import 'package:kb4yg/screens/parking.dart';
// import 'package:kb4yg/screens/parking_area.dart';
// import 'package:kb4yg/screens/select_county.dart';
// import 'package:kb4yg/screens/home.dart';
// import 'package:kb4yg/utilities/screen_arguments.dart';
// import 'package:kb4yg/utilities/constants.dart' as constants;
// import 'package:kb4yg/widgets/app.dart';
//
//
// MaterialPageRoute routeHandler(BuildContext context, RouteSettings settings) {
//   print(settings);
//
//
//   // Handle '/'
//   if (settings.name == constants.routeHome || settings.name == constants.routeRoot) {
//     // Display navigation bar if on mobile (else display Home())
//     if (kIsWeb) {
//       return MaterialPageRoute(
//           settings: settings,
//           maintainState: true,
//           builder: (context) => const NavBarWrapper());
//     } else {
//       return MaterialPageRoute(
//           settings: settings,
//           maintainState: false,
//           builder: (context) => const HomeScreen());
//     }
//   }
//
//   var uri = Uri.parse(settings.name!);
//
//   // Handle 'parking/*'
//   if (uri.pathSegments.first == constants.routeLocations) {
//     // '/parking/:county'
//     if (uri.pathSegments.length == 2) {
//       // Get '/:county' portion of url && Capitalize for standardization
//       var county = uri.pathSegments[1];
//       county = county[0].toUpperCase() + county.substring(1);
//
//       // Push Parking() screen if valid county specified in url
//       final counties = Counties.of(context);
//       if (counties[county] != null) {
//         return MaterialPageRoute(
//             maintainState: false,
//             settings: settings,
//             builder: (context) => CountyDetailsScreen(county: counties[county]));
//       }
//     }
//     // '/parking/' -> SelectCounty
//     else if (uri.pathSegments.length == 1) {
//       return MaterialPageRoute(
//           maintainState: false,
//           settings: settings,
//           builder: (context) => const CountyListScreen()
//       );
//     }
//   }
//
//   else if (uri.pathSegments.length == 2 && uri.pathSegments.first == constants.routeLocations) {
//     var loc = getArgs(settings)?.location;
//     if (loc != null) {
//       return MaterialPageRoute(
//         maintainState: false,
//         settings: settings,
//         builder: (context) => ParkingArea(location: loc));
//     }
//   }
//
//   else if (uri.pathSegments.first == constants.routeAboutName) {
//     return MaterialPageRoute(
//       // maintainState: true,
//       settings: settings,
//       builder: (context) => const AboutScreen());
//   }
//   else if (uri.pathSegments.first == constants.routeHelpName) {
//     return MaterialPageRoute(
//       settings: settings,
//       builder: (context) => const HelpScreen());
//   }
//
//
//
//   // TODO: create unknown/error screen
//   return MaterialPageRoute(
//       settings: settings,
//       builder: (context) => const HomeScreen());
// }
