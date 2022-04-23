import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/county.dart';
import '../models/parking_lot.dart';
import '../models/recreation_area.dart';

class BackendProvider {
  static const domain = 'dw03b89ydk.execute-api.us-west-2.amazonaws.com';

  BackendProvider();

  Future<http.Response> queryBackend(Map<String, String>? parameters) async {
    if (kDebugMode) print('API CALL\n\t- parameters: $parameters');
    var url = Uri.https(domain, '/location', parameters);

    http.Response response;
    try {
      response = await http.get(url, headers: {'Accept': 'application/json'});
    } catch (e) {
      throw Exception('Failed to connect to our servers: $e');
    }

    if (kDebugMode) print('\t- status code: ${response.statusCode}');
    if (response.statusCode == 200) return response;

    throw Exception('Failed to fetch location data from API: ${response.body}');
  }

  Future<List<ParkingLot>> fetchParkingLots() async {
    var response = await queryBackend(null);
    var jsonObj = json.decode(response.body);
    var parkingLots = [for (var item in jsonObj) ParkingLot.fromJson(item)];
    return parkingLots;
  }

  Future<ParkingLot> getParkingLot(String parkingLotName) async {
    var response = await queryBackend({'LocationURL': parkingLotName});
    var jsonObj = json.decode(response.body);
    var parkingLot = ParkingLot.fromJson(jsonObj[0]);
    return parkingLot;
  }

  Future<RecreationArea> getRecreationArea(String recreationAreaUrl) async {
    var response = await queryBackend({'ParkURL': recreationAreaUrl});
    // check if not empty for RecreationArea/County or error code in future
    var jsonObj = Map<String, dynamic>.from(json.decode(response.body));
    var recreationArea = RecreationArea.fromJson(jsonObj);
    return recreationArea;
  }

  Future<County> getCounty(String countyUrl) async {
    var response = await queryBackend({'CountyURL': countyUrl});
    var jsonObj = json.decode(response.body);
    var county = County.fromJson(jsonObj);
    return county;
  }

  Future<List<String>> getCountyList({String state = 'OR'}) async {
    var response = await queryBackend({'county': 'all'});
    var jsonObj = json.decode(response.body);
    var countyList = List<String>.from(jsonObj['Counties']);
    return countyList;
  }

  // Context accessor (ex: "var backend = BackendProvider.of(context);" )
  static BackendProvider of(BuildContext context) =>
      Provider.of<BackendProvider>(context, listen: false);
}
