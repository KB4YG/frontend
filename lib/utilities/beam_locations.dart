import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' show BuildContext, ValueKey;
import 'package:kb4yg/extensions/string_extension.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/models/county_list.dart';
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
      var countyName = sanitizeUrl(state.pathParameters[routeCountyId]!);
      County? county = Counties.of(context)[countyName];
      if (county != null) {
        pages.add(BeamPage(
            key: ValueKey('county-$countyName'),
            title: county.name.capitalize(),
            type: BeamPageType.noTransition,
            child: CountyScreen(county: county)));
      }
    }
    if (state.pathParameters.containsKey(routeRecAreaId)) {
      var recreationAreaName = sanitizeUrl(state.pathParameters[routeRecAreaId]!);
      RecreationArea? recreationArea = Counties.of(context).getRecArea(recreationAreaName);
      if (recreationArea != null) {
        pages.add(BeamPage(
            key: ValueKey('rec-area-$recreationAreaName'),
            title: recreationArea.name.capitalize(),
            type: BeamPageType.noTransition,
            child: RecreationAreaScreen(location: recreationArea)
        ));
      }
    }
    return pages;
  }
}