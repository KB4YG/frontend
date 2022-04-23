import 'package:kb4yg/models/parking_lot.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/providers/backend.dart';

import 'fire_danger.dart';

class County {
  final String name;
  final double lat;
  final double lng;
  List<RecreationArea> recreationAreas;
  late List<ParkingLot> parkingLots;
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
