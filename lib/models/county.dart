import 'package:kb4yg/models/parking_lot.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/providers/backend.dart';

import 'fire_danger.dart';

class County {
  final String name;
  final double lat = 44.5646;   // TODO remove placeholders
  final double lng = -123.2620;
  List<RecreationArea> recreationAreas;
  late List<ParkingLot> parkingLots;
  late final FireDanger fireDanger = [for (var x in recreationAreas) x.fireDanger]
      .fold(recreationAreas[0].fireDanger, (p, c) => p.level.index > c.level.index ? p : c);

  County(this.name, this.recreationAreas);

  County.fromJson(Map<String, dynamic> json)
      : name = json['County'],
        recreationAreas = [
          for (var item in json['List'])
            RecreationArea.fromJson(
                List<Map<String, dynamic>>.from(item['List']))
        ] {
    parkingLots = [for (var recArea in recreationAreas) ...recArea.parkingLots];
  }

  Future<void> refresh(context) async {
    final updatedCounty = await BackendProvider.of(context).getCounty(name);
    recreationAreas = updatedCounty.recreationAreas;
    parkingLots = updatedCounty.parkingLots;
  }
}
