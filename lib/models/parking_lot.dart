import 'fire_danger.dart';

class ParkingLot {
  final String name;
  final String address; // Address of parking lot (able to put into Google Maps)
  final double lat; // Latitude of address, decimal degrees
  final double lng; // Longitude of address, decimal degrees
  final int spots; // Number of general parking spots currently available
  final int handicap; // Number of handicap parking currently available
  final String recreationArea; // Name of recreation area parking lot is in
  final FireDanger fireDanger; // ODF Term - low, moderate, high, or extreme

  ParkingLot(this.name, this.address, this.lat, this.lng, this.spots,
      this.handicap, this.fireDanger, this.recreationArea);

  ParkingLot.fromJson(Map<String, dynamic> json)
      : name = json['ParkingLotName'],
        address = json['Address'],
        lat = json['Latitude'],
        lng = json['Longitude'],
        spots = json['TotalGeneral'],
        handicap = json['TotalHandicap'],
        recreationArea = json['RecreationArea'],
        fireDanger = FireDanger.fromJson(json['FireDanger']);
}
