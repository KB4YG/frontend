import 'package:kb4yg/models/parking_lot.dart';

import 'fire_danger.dart';

class RecreationArea {
  final String name;
  final String info;
  final String parkingLotUrl;
  final List<String> imageUrls;
  final List<ParkingLot> parkingLots;
  late final int spots =
      [for (var x in parkingLots) x.spots].fold(0, (p, c) => p + c);
  late final int handicap =
      [for (var x in parkingLots) x.handicap].fold(0, (p, c) => p + c);
  late final FireDanger fireDanger = [for (var x in parkingLots) x.fireDanger]
      .fold(parkingLots[0].fireDanger, (p, c) => p.level.index > c.level.index ? p : c);

  RecreationArea.fromJson(Map<String, dynamic> json)
      : name = json['RecreationArea'],
        info = json['About'],
        parkingLotUrl = json['List'][0]['ParkURL'],
        imageUrls = List<String>.from(json['Images']),
        parkingLots = [for (var item in json['List']) ParkingLot.fromJson(item)];
}
