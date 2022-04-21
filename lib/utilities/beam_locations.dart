import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart' show BuildContext, ValueKey;
import 'package:kb4yg/extensions/string_extension.dart';
import 'package:kb4yg/screens/about_screen.dart';
import 'package:kb4yg/screens/county_list/county_list_screen.dart';
import 'package:kb4yg/screens/county/county_screen.dart';
import 'package:kb4yg/screens/help_screen.dart';
import 'package:kb4yg/screens/home/home_screen.dart';
import 'package:kb4yg/screens/recreation_area/recreation_area_screen.dart';
import 'package:kb4yg/utilities/constants.dart';
import 'package:kb4yg/utilities/sanitize_url.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [HomeScreen.path, routeRoot];

  @override
  List<BeamPage> buildPages(context, state) => [HomeScreen.beamPage];
}

class HelpLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [HelpScreen.path];

  @override
  List<BeamPage> buildPages(context, state) => [HelpScreen.beamPage];
}

class AboutLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [AboutScreen.path];

  @override
  List<BeamPage> buildPages(context, state) => [AboutScreen.beamPage];
}

class CountyLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [routeRecArea];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    BeamPage page;

    var url = sanitizeUrl(state.uri.toString()).replaceAll(routeLocations, '');
    if (kDebugMode) print('URL - "$url"');

    if (state.pathParameters.containsKey(routeRecAreaId)) {
      // Guess the recreation area name based on url
      var recreationAreaName =
          sanitizeUrl(state.pathParameters[routeRecAreaId]!)
              .replaceAll('-', ' ')
              .capitalizeAll();
      page = BeamPage(
          key: ValueKey('rec-area-$url'),
          title: recreationAreaName,
          type: BeamPageType.fadeTransition,
          child: RecreationAreaScreen(recreationAreaName, url));
    } else if (state.pathParameters.containsKey(routeCountyId)) {
      var countyName = state.pathParameters[routeCountyId]!.capitalize();
      page = BeamPage(
          key: ValueKey('county-$countyName'),
          title: countyName.capitalize(),
          type: BeamPageType.noTransition,
          child: CountyScreen(countyName, url));
    } else {
      page = const BeamPage(
          key: ValueKey('county-list'),
          title: 'Counties',
          type: BeamPageType.fadeTransition,
          child: CountyListScreen());
    }

    return [page];
  }
}
