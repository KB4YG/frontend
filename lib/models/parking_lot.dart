import '../utilities/constants.dart';
import 'fire_danger.dart';

class ParkingLot {
  final String name;
  final String address; // Address of parking lot (able to put into Google Maps)
  final double lat; // Latitude of address, decimal degrees
  final double lng; // Longitude of address, decimal degrees
  late final int spots; // Number of general parking spots currently available
  late final int handicap; // Number of handicap parking currently available
  final String county; // Name of county parking lot is in
  final String recreationArea; // Name of recreation area parking lot is in
  final FireDanger fireDanger; // ODF Term - low, moderate, high, or extreme
  late final DateTime dt; // Datetime the parking spot count was last updated
  final Map<String, String> links = {}; // Links to county / rec area pages

  ParkingLot.fromJson(Map<String, dynamic> json)
      : name = json['ParkingLotName'],
        address = json['Address'],
        lat = json['Latitude'],
        lng = json['Longitude'],
        county = json['County'],
        recreationArea = json['RecreationArea'],
        fireDanger = FireDanger.fromJson(json['FireDanger']) {
    links[linkRecArea] = routeLocations + json['ParkURL'];
    links[linkCounty] = routeLocations + json['CountyURL'];
    // Handle edge case of empty parking data (shouldn't happen but could)
    if ((json['ParkingData'] as List).isNotEmpty) {
      spots = json['ParkingData'][0]['OpenGeneral'];
      handicap = json['ParkingData'][0]['OpenHandicap'];
      dt = json['ParkingData'][0]['LastUpdate'];
    } else {
      spots = -1;
      handicap = -1;
      dt = DateTime.fromMillisecondsSinceEpoch(0);
    }

  }

  String get spotsStr => spots < 0 ? 'n/a' : spots.toString();
  String get handicapStr => handicap < 0 ? 'n/a' : handicap.toString();
}
