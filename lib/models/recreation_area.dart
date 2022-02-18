import 'package:kb4yg/models/parking_lot.dart';

class RecreationArea {
  final String name;
  final String info = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
      ' sed do eiusmod tempor incididunt ut labore et dolore '
      'magna aliqua. Ut enim ad minim veniam, quis nostrud '
      'exercitation ullamco laboris nisi ut aliquip ex ea '
      'commodo consequat. Duis aute irure dolor in '
      'reprehenderit in voluptate velit esse cillum dolore eu '
      'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
      'non proident, sunt in culpa qui officia deserunt mollit '
      'anim id est laborum.';
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

  RecreationArea(this.name, this.parkingLots);

  RecreationArea.fromJson(List<Map<String, dynamic>> json)
      : name = json[0]['RecreationArea'],
        parkingLots = [for (var item in json) ParkingLot.fromJson(item)];
}
