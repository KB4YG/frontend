import 'package:kb4yg/models/parking_lot.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/providers/backend.dart';

import 'fire_danger.dart';

/// Collection of recreation areas.
class County {
  final String name;
  /// Latitude of county that ParkingMap() uses to center view.
  final double lat;
  /// Longitude of county that ParkingMap() uses to center view.
  final double lng;
  /// Recreation areas in county.
  List<RecreationArea> recreationAreas;
  /// All parking lots in county
  late List<ParkingLot> parkingLots;
  /// Highest fire danger level in county.
  late final FireDanger fireDanger = [
    for (var x in recreationAreas) x.fireDanger
  ].fold(recreationAreas[0].fireDanger,
      (p, c) => p.level.index > c.level.index ? p : c);

  County.fromJson(Map<String, dynamic> json)
      : name = json['County'],
        lat = json['Latitude'],
        lng = json['Longitude'],
        recreationAreas = [
          for (var recArea in json['List']) RecreationArea.fromJson(recArea)
        ] {
    parkingLots = [for (var recArea in recreationAreas) ...recArea.parkingLots];
  }

  Future<void> refresh(context) async {
    final updatedCounty = await BackendProvider.of(context).getCounty(name);
    recreationAreas = updatedCounty.recreationAreas;
    parkingLots = updatedCounty.parkingLots;
  }
}
