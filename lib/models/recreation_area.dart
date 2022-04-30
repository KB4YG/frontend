import 'package:kb4yg/models/parking_lot.dart';

import 'fire_danger.dart';

/// Collection of parking lots.
class RecreationArea {
  final String name;
  /// Description of recreation area.
  final String info;
  /// HATEOAS link to parking lot details.
  final String parkingLotUrl;
  /// Web address of associated nature images.
  final List<String> imageUrls;
  /// ALl parking lots in recreation area.
  final List<ParkingLot> parkingLots;
  /// General parking spots available amongst parking lots.
  late final int spots =
      [for (var x in parkingLots) x.spots].fold(0, (p, c) => p + c);
  /// Handicap parking spots available amongst parking lots.
  late final int handicap =
      [for (var x in parkingLots) x.handicap].fold(0, (p, c) => p + c);
  /// Least recent timestamp (time updated) amongst parking lots.
  late final DateTime dt = [for (var x in parkingLots) x.dt]
      .fold(parkingLots[0].dt, (p, c) => p.isAfter(c) ? c : p);
  /// Highest fire danger level amongst parking lots.
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
  String get handicapStr => handicap < 0 ? 'n/a' : handicap.toString();
}
