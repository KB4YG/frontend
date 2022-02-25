import 'package:kb4yg/models/parking_lot.dart';

import 'fire_danger.dart';

class RecreationArea {
  final String name;
  final String info;
  final List<String> imageUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'
  ];
  final List<ParkingLot> parkingLots;
  int get spots =>
      [for (var x in parkingLots) x.spots].fold(0, (p, c) => p + c);
  int get handicap =>
      [for (var x in parkingLots) x.handicap].fold(0, (p, c) => p + c);
  late final FireDanger fireDanger = [for (var x in parkingLots) x.fireDanger]
      .fold(parkingLots[0].fireDanger, (p, c) => p.level.index > c.level.index ? p : c);

  RecreationArea(this.name, this.info, this.parkingLots);

  RecreationArea.fromJson(List<Map<String, dynamic>> json)
      : name = json[0]['RecreationArea'],
        info = json[0]['About'],
        parkingLots = [for (var item in json) ParkingLot.fromJson(item)];
}
