import 'package:flutter/material.dart' show ModalRoute, BuildContext, RouteSettings;
import 'package:kb4yg/models/access_point.dart';
import 'package:kb4yg/models/county.dart';


class ScreenArguments {
  final County? county;
  final AccessPoint? location;
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
