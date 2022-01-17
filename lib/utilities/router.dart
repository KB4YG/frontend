import 'package:flutter/material.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/screens/parking.dart';
import 'package:kb4yg/screens/parking_area.dart';
import 'package:kb4yg/screens/select_county.dart';
import 'package:kb4yg/screens/home.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;


MaterialPageRoute routeHandler(RouteSettings settings, Counties counties, SharedPreferences prefs) {
  print(settings);

  // Handle '/'
  if (settings.name == constants.routeHome) {
    return MaterialPageRoute(
        settings: settings,
        maintainState: false,
        builder: (context) => const Home());
  }

  var uri = Uri.parse(settings.name!);

  // Handle 'parking/*'
  if (uri.pathSegments.first == constants.routeParkingName) {
    // '/parking/:county'
    if (uri.pathSegments.length == 2) {
      // Get '/:county' portion of url && Capitalize for standardization
      var county = uri.pathSegments[1];
      county = county[0].toUpperCase() + county.substring(1);

      // Push Parking() screen if valid county specified in url
      if (counties[county] != null) {
        return MaterialPageRoute(
            maintainState: false,
            settings: settings,
            builder: (context) => Parking(county: counties[county]));
      }
    }
    // '/parking/' -> SelectCounty
    else if (uri.pathSegments.length == 1) {
      // Get last selected county if available
      final args = ScreenArguments.getArgs(settings);

      return MaterialPageRoute(
          maintainState: false,
          settings: settings,
          builder: (context) => SelectCounty(
              prefs: prefs,
              counties: counties,
              lastCounty: args?.county?.name
          )
      );
    }
  }

  else if (uri.pathSegments.length == 2 && uri.pathSegments.first == constants.routeLocationName) {
    // var county = uri.pathSegments[1];
    // county = county[0].toUpperCase() + county.substring(1);
    //
    // // Push Parking() screen if valid county specified in url
    // if (counties[county] != null) {
    //   return MaterialPageRoute(
    //       maintainState: false,
    //       settings: settings,
    //       builder: (context) => Parking(county: counties[county]));
    // }
    final args = ScreenArguments.getArgs(settings);
    if (args != null && args.location != null) {
      return MaterialPageRoute(
          maintainState: false,
          settings: settings,
          builder: (context) => ParkingArea(location: args.location!)
      );
    }
  }



  // TODO: create unknown/error screen
  return MaterialPageRoute(
      settings: settings,
      builder: (context) => const Home());
}
