import 'package:flutter/material.dart' show Colors, MaterialColor;
import 'package:kb4yg/extensions/string_extension.dart';

enum Danger {unknown, low, moderate, high, extreme}

class FireDanger {
  final int lastUpdated;
  final String levelStr;
  late final Danger level = levelFromStr(levelStr);
  late final MaterialColor color = matchFireDangerColor(level);

  FireDanger(this.lastUpdated, this.levelStr);

  FireDanger.fromJson(Map<String, dynamic> json)
      : lastUpdated = json['LastUpdate'],
        levelStr = json['Level'];

  Danger levelFromStr(String levelStr) {
    switch (levelStr.toLowerCase()) {
      case 'low':       return Danger.low;
      case 'moderate':  return Danger.moderate;
      case 'high':      return Danger.high;
      case 'extreme':   return Danger.extreme;
      default:          return Danger.unknown;
    }
  }

  @override
  String toString() => levelStr.capitalize();
}

MaterialColor matchFireDangerColor(Danger? danger) {
  switch (danger) {
    case (Danger.low):      return Colors.green;
    case (Danger.moderate): return Colors.blue;
    case (Danger.high):     return Colors.amber;
    case (Danger.extreme):  return Colors.red;
    default:                return Colors.grey;
  }
}