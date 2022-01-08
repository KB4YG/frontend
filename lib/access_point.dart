import 'dart:convert';
import 'dart:math'; // TODO: remove temporary dependency
import 'package:http/http.dart';

final _random = Random();

class AccessPoint {
  static const url = 'https://cfb32cwake.execute-api.us-west-2.amazonaws.com/';
  final String name; // name of parking lot / recreation area
  int spots; // number of general parking spots currently available
  int handicap; // number of handicap parking currently available

  // Constructor 1:
  //  AccessPoint loc = AccessPoint();
  //  await loc.getParking();
  AccessPoint(this.name, {this.spots = 0, this.handicap = 0});

  // Constructor 2:
  //  AccessPoint loc = await AccessPoint.create();
  AccessPoint._(this.name, {this.spots = 0, this.handicap = 0});
  static Future<AccessPoint> create(name) async {
    var accessPoint = AccessPoint._(name);
    await accessPoint.getParking();
    return accessPoint;
  }

  String getName() => name;

  Future<void> getParking() async {
    try {
      // TODO: remove random numbers
      // Response response = await get(Uri.parse('$url$name'));
      // Map data = jsonDecode(response.body);
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

}
