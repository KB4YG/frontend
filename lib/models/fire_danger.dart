import 'package:flutter/material.dart' show Colors, MaterialColor;
enum Danger {low, moderate, high, extreme}

class FireDanger {
  final int lastUpdated;
  final String levelStr;
  Danger? get level => levelFromStr(levelStr);
  MaterialColor? get color => matchFireDangerColor(level);

  FireDanger(this.lastUpdated, this.levelStr);

  FireDanger.fromJson(Map<String, dynamic> json)
      : lastUpdated = json['LastUpdate'],
        levelStr = json['Level'];

  Danger? levelFromStr(String levelStr) {
    switch (levelStr) {
      case 'low': return Danger.low;
      case 'moderate': return Danger.moderate;
      case 'high': return Danger.high;
      case 'extreme': return Danger.extreme;
      default: return null;
    }
  }
}

MaterialColor matchFireDangerColor(Danger? danger) {
  switch (danger) {
    case (Danger.low): return Colors.green;
    case (Danger.moderate): return Colors.blue;
    case (Danger.high): return Colors.yellow;
    case (Danger.extreme): return Colors.red;
    default: return Colors.grey;
  }
}