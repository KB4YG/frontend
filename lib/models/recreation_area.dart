import 'package:kb4yg/models/parking_lot.dart';

import 'fire_danger.dart';

class RecreationArea {
  final String name;
  final String info; // Description of recreation area
  final String parkingLotUrl; // URL path to parking lot
  final List<String> imageUrls; // Web address of associated nature images
  final List<ParkingLot> parkingLots;
  // Sum general spots
  late final int spots =
      [for (var x in parkingLots) x.spots].fold(0, (p, c) => p + c);
  // Sum handicap spots
  late final int handicap =
      [for (var x in parkingLots) x.handicap].fold(0, (p, c) => p + c);
  // Get least recent timestamp amongst parking lots
  late final DateTime dt = [for (var x in parkingLots) x.dt]
      .fold(parkingLots[0].dt, (p, c) => p.isAfter(c) ? c : p);
  // Get highest fire danger level enum amongst parking lots
  late final FireDanger fireDanger = [for (var x in parkingLots) x.fireDanger]
      .fold(parkingLots[0].fireDanger,
          (p, c) => p.level.index > c.level.index ? p : c);

  RecreationArea.fromJson(Map<String, dynamic> json)
      : name = json['RecreationArea'],
        info = json['About'],
        parkingLotUrl = json['List'][0]['ParkURL'],
        imageUrls = List<String>.from(json['Images']),
        parkingLots = [
          for (var item in json['List']) ParkingLot.fromJson(item)
        ] {
    // Alphabetize parking lots by name
    parkingLots.sort((loc1, loc2) => loc1.name.compareTo(loc2.name));
  }

  String get spotsStr => spots < 0 ? 'n/a' : spots.toString();
}
