import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart' show BuildContext;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/county.dart';
import '../models/parking_lot.dart';
import '../models/recreation_area.dart';

/// Singleton class to interface queries between client and server.
class BackendProvider {
  static const domain = 'dw03b89ydk.execute-api.us-west-2.amazonaws.com';
  static const endpoint = '/locations';

  BackendProvider();

  /// Queries backend [domain]
  Future<http.Response> queryBackend(Map<String, String>? parameters) async {
    if (kDebugMode) print('API CALL\n\t- parameters: $parameters');
    var url = Uri.https(domain, endpoint, parameters);

    http.Response response;
    try {
      response = await http.get(url, headers: {'Accept': 'application/json'});
    } catch (e) {
      throw Exception('Failed to connect to our servers: $e');
    }

    if (kDebugMode) print('\t- status code: ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    throw Exception('Failed to fetch location data from API: ${response.body}');
  }

  /// Get list of all parking lots in state.
  Future<List<ParkingLot>> fetchParkingLots() async {
    var response = await queryBackend(null);
    var jsonObj = json.decode(response.body);
    var parkingLots = [for (var item in jsonObj) ParkingLot.fromJson(item)];
    return parkingLots;
  }

  /// Get a specific parking lot by its name.
  Future<ParkingLot> getParkingLot(String parkingLotName) async {
    var response = await queryBackend({'LocationURL': parkingLotName});
    var jsonObj = json.decode(response.body);
    var parkingLot = ParkingLot.fromJson(jsonObj[0]);
    return parkingLot;
  }

  /// Get RecreationArea() object from corresponding URL.
  Future<RecreationArea> getRecreationArea(String recreationAreaUrl) async {
    var response = await queryBackend({'ParkURL': recreationAreaUrl});
    // check if not empty for RecreationArea/County or error code in future
    var jsonObj = Map<String, dynamic>.from(json.decode(response.body));
    var recreationArea = RecreationArea.fromJson(jsonObj);
    return recreationArea;
  }

  /// Get County() object from corresponding URL.
  Future<County> getCounty(String countyUrl) async {
    var response = await queryBackend({'CountyURL': countyUrl});
    var jsonObj = json.decode(response.body);
    var county = County.fromJson(jsonObj);
    return county;
  }

  /// Get list of county names KB4YG supports.
  Future<List<String>> getCountyList({String state = 'OR'}) async {
    var response = await queryBackend({'CountyURL': 'all'});
    var jsonObj = json.decode(response.body);
    var countyList = List<String>.from(jsonObj['Counties']);
    return countyList;
  }

  // Context accessor (ex: "var backend = BackendProvider.of(context);" )
  static BackendProvider of(BuildContext context) =>
      Provider.of<BackendProvider>(context, listen: false);
}
