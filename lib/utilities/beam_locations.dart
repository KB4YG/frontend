import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' show BuildContext, ValueKey;
import 'package:kb4yg/extensions/string_extension.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/screens/about_screen.dart';
import 'package:kb4yg/screens/county_list_screen.dart';
import 'package:kb4yg/screens/county_screen.dart';
import 'package:kb4yg/screens/help_screen.dart';
import 'package:kb4yg/screens/home_screen.dart';
import 'package:kb4yg/screens/recreation_area_screen.dart';
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
    List<BeamPage> pages = [
      const BeamPage(
          key: ValueKey('county-list'),
          title: 'Counties',
          type: BeamPageType.noTransition,
          child: CountyListScreen())
    ];

    if (state.pathParameters.containsKey(routeCountyId)) {
      var countyName =
          sanitizeUrl(state.pathParameters[routeCountyId]!).capitalize();
      pages.add(BeamPage(
          key: ValueKey('county-$countyName'),
          title: countyName,
          type: BeamPageType.noTransition,
          child: CountyScreen(countyName)));
    }

    if (state.pathParameters.containsKey(routeRecAreaId)) {
      var recreationAreaPath =
          Uri.parse(state.pathParameters[routeRecAreaId]!).toString();
      pages.add(BeamPage(
          key: ValueKey('rec-area-$recreationAreaPath'),
          title: recreationAreaPath,
          type: BeamPageType.noTransition,
          child: RecreationAreaScreen(recreationAreaPath)));
    }

    return pages;
  }
}
