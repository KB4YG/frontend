import 'package:flutter/material.dart' show ModalRoute, BuildContext, RouteSettings;
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/models/recreation_area.dart';


class ScreenArguments {
  final County? county;
  final RecreationArea? location;
  final String? lastCounty;

  ScreenArguments({this.county, this.location, this.lastCounty});

  static ScreenArguments? of(BuildContext context) {
    final settings = ModalRoute.of(context)?.settings;
    return settings != null ? getArgs(settings) : null;
  }

  @override
  String toString() => 'ScreenArguments('
      'county: $county, '
      'location: $location, '
      'lastCounty: $lastCounty)';
}

ScreenArguments? getArgs(RouteSettings settings) =>
    settings.arguments == null ? null : settings.arguments as ScreenArguments;
