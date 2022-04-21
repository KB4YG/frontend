import '../utilities/constants.dart';
import 'fire_danger.dart';

class ParkingLot {
  final String name;
  final String address; // Address of parking lot (able to put into Google Maps)
  final double lat; // Latitude of address, decimal degrees
  final double lng; // Longitude of address, decimal degrees
  final int spots; // Number of general parking spots currently available
  final int handicap; // Number of handicap parking currently available
  final String county; // Name of county parking lot is in
  final String recreationArea; // Name of recreation area parking lot is in
  final FireDanger fireDanger; // ODF Term - low, moderate, high, or extreme
  final DateTime dt; // Date and time the parking spot count was last updated
  final Map<String, String> links = {}; // Links to county / rec area pages

  ParkingLot.fromJson(Map<String, dynamic> json)
      : name = json['ParkingLotName'],
        address = json['Address'],
        lat = json['Latitude'],
        lng = json['Longitude'],
        spots = json['ParkingData'].length == 0
            ? -1
            : json['ParkingData'][0]['OpenGeneral'],
        handicap = json['ParkingData'].length == 0
            ? -1
            : json['ParkingData'][0]['OpenHandicap'],
        county = json['County'],
        recreationArea = json['RecreationArea'],
        fireDanger = FireDanger.fromJson(json['FireDanger']),
        dt = DateTime.fromMillisecondsSinceEpoch(json['ParkingData'].length == 0
            ? 0
            : json['ParkingData'][0]['LastUpdate']) {
    links[linkRecArea] = routeLocations + json['ParkURL'];
    links[linkCounty] = routeLocations + json['CountyURL'];
  }

  String get spotsStr => spots < 0 ? 'n/a' : spots.toString();
  String get handicapStr => handicap < 0 ? 'n/a' : handicap.toString();
}
