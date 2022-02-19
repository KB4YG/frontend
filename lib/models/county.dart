import 'package:kb4yg/models/parking_lot.dart';
import 'package:kb4yg/models/recreation_area.dart';

class County {
  final String name;
  // TODO remove placeholders & connect to county_screen.dart for FlutterMap()
  final double lat = 44.5646;
  final double lng = -123.2620;
  final List<RecreationArea> recreationAreas;
  late final List<ParkingLot> parkingLots;

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
}
