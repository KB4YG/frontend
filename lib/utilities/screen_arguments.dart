import 'package:flutter/material.dart' show RouteSettings;
import 'package:kb4yg/models/access_point.dart';
import 'package:kb4yg/models/county.dart';

const argCounty = 0;

class ScreenArguments {
  final County? county;
  final AccessPoint? location;
  final int? navIndex;

  ScreenArguments({this.county, this.location, this.navIndex});

  static getArgs(RouteSettings settings) =>
      settings.arguments == null ? null : settings.arguments as ScreenArguments;

  @override
  String toString() => 'ScreenArguments($county)';
}
