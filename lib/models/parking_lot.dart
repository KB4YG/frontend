import '../constants.dart';
import 'fire_danger.dart';

/// Access point to a recreation area.
class ParkingLot {
  final String name;
  /// Address of parking lot (able to put into Google Maps).
  final String address;
  /// Latitude of address, decimal degrees.
  final double lat;
  /// Longitude of address, decimal degrees.
  final double lng;
  /// Number of general parking spots currently available. Negative values indicate a lack of existence or an error.
  late final int spots;
  /// Number of handicap parking currently available. Negative values indicate a lack of existence or an error.
  late final int handicap;
  /// Name of county parking lot is in.
  final String county;
  /// Name of recreation area parking lot is in.
  final String recreationArea;
  /// ODF Term - low, moderate, high, or extreme.
  final FireDanger fireDanger;
  /// Datetime the parking spot count was last updated. Set to epoch if error.
  late final DateTime dt;
  /// HATEOAS links to county / rec area pages.
  final Map<String, String> links = {};

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
      // First entry is most recent (sorted in database by timestamp)
      int spotsGeneral = json['ParkingData'][0]['UsedGeneral'];
      int spotsHandicap = json['ParkingData'][0]['UsedHandicap'];
      spots = spotsGeneral < 0 ? -1 : json['TotalGeneral'] - spotsGeneral;
      handicap = spotsHandicap < 0 ? -1 : json['TotalHandicap'] - spotsHandicap;
      dt = DateTime.fromMillisecondsSinceEpoch(
          json['ParkingData'][0]['LastUpdate']);
    } else {
      spots = -1;
      handicap = -1;
      dt = DateTime.fromMillisecondsSinceEpoch(0);
    }
  }

  String get spotsStr => spots < 0 ? 'n/a' : spots.toString();
  String get handicapStr => handicap < 0 ? 'n/a' : handicap.toString();
}
