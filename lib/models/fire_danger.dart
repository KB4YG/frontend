import 'package:flutter/material.dart' show Colors, MaterialColor;
import 'package:kb4yg/extensions/string_extension.dart';

enum Danger { unknown, low, moderate, high, extreme }

/// Risk of fires for a region. Designated by Oregon Department of Forestry (ODF).
class FireDanger {
  /// Datetime of update in milliseconds since epoch.
  final int lastUpdated;
  /// ODF fire danger level (low, moderate, high, extreme).
  final String levelStr;
  /// Enum of levelStr (unknown, low, moderate, high, extreme).
  late final Danger level = levelFromStr(levelStr);
  /// Color associated with danger level.
  late final MaterialColor color = matchFireDangerColor(level);

  FireDanger.fromJson(Map<String, dynamic> json)
      : lastUpdated = json['LastUpdate'],
        levelStr = json['Level'];

  @override
  String toString() => levelStr.capitalize();
}

/// Get Danger enum value from string representation (e.g., 'low' -> Danger.low).
Danger levelFromStr(String levelStr) {
  switch (levelStr.toLowerCase()) {
    case 'low':       return Danger.low;
    case 'moderate':  return Danger.moderate;
    case 'high':      return Danger.high;
    case 'extreme':   return Danger.extreme;
    default:          return Danger.unknown;
  }
}

/// Get color associated with danger level (e.g., Danger.low -> Colors.green).
MaterialColor matchFireDangerColor(Danger? danger) {
  switch (danger) {
    case (Danger.low):      return Colors.green;
    case (Danger.moderate): return Colors.blue;
    case (Danger.high):     return Colors.amber;
    case (Danger.extreme):  return Colors.red;
    default:                return Colors.grey;
  }
}
