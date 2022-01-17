import 'dart:convert';
import 'dart:math'; // TODO: remove temporary dependency
import 'package:http/http.dart';

final _random = Random();

class AccessPoint {
  static const url = 'https://cfb32cwake.execute-api.us-west-2.amazonaws.com/';
  final String name;    // Name of parking lot / recreation area
  int spots;            // Number of general parking spots currently available
  int handicap;         // Number of handicap parking currently available
  final String address; // Address of parking lot (able to put into Google Maps
  final double lat;     // Latitude of address, decimal degrees
  final double lng;     // Longitude of address, decimal degrees

  // Constructor 1:
  //  AccessPoint loc = AccessPoint();
  //  await loc.getParking();
  AccessPoint(this.name, {
    required this.address,
    required this.lat, required this.lng,
    this.spots = 0, this.handicap = 0
  });

  // Constructor 2:
  //  AccessPoint loc = await AccessPoint.create({parameters});
  AccessPoint._(this.name, this.address, this.lat, this.lng,
      {this.spots = 0, this.handicap = 0});
  static Future<AccessPoint> create(name, addr, lat, long) async {
    var accessPoint = AccessPoint._(name, addr, lat, long);
    await accessPoint.getParking();
    return accessPoint;
  }

  Future<void> getParking() async {
    try {
      // TODO: remove random numbers
      // Response response = await get(Uri.parse('$url'), headers: {'Location': name});
      // Map data = jsonDecode(response.body);
      // print(data);
      Map data = {'spots': _random.nextInt(10), 'handicap': _random.nextInt(10)};
      try {
        spots = data['spots'];
        handicap = data['handicap'];
      } on TypeError {
        print('API ERROR: ${data['message']}');
      }
    } on NoSuchMethodError {
      print('!!!API IS DOWN!!!');
    }
  }

  @override
  String toString() => name;
}
