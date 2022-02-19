import 'dart:convert';

import 'package:flutter/material.dart' show BuildContext;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/county.dart';
import '../models/parking_lot.dart';
import '../models/recreation_area.dart';

class BackendProvider {
  static const domain = 'cfb32cwake.execute-api.us-west-2.amazonaws.com';
  BackendProvider();

  Future<http.Response> getLocation(Map<String, String>? parameters) async {
    print('API CALL - parameters: $parameters');
    var url = Uri.https(domain, '/location', parameters);
    var response = await http.get(url, headers: {'Accept': 'application/json'});
    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to fetch location data from API');
    }
  }

  Future<ParkingLot> getParkingLot(String parkingLotName) async {
    var response = await getLocation({'parkingLotName': parkingLotName});
    var jsonObj = json.decode(response.body);
    var parkingLot = ParkingLot.fromJson(jsonObj[0]);
    return parkingLot;
  }

  Future<RecreationArea> getRecreationArea(String recreationAreaUrl) async {
    var response = await getLocation({'ParkURL': recreationAreaUrl});
    // check if not empty for RecreationArea/County or error code in future
    var jsonObj = List<Map<String, dynamic>>.from(json.decode(response.body));
    var recreationArea = RecreationArea.fromJson(jsonObj);
    return recreationArea;
  }

  Future<County> getCounty(String countyName) async {
    var response = await getLocation({'county': countyName});
    var jsonObj = json.decode(response.body);
    var county = County.fromJson(jsonObj);
    return county;
  }

  Future<List<String>> getCountyList({String state = 'OR'}) async {
    var response = await getLocation({'county': 'all'});
    var jsonObj = json.decode(response.body);
    var countyList = List<String>.from(jsonObj['Counties']);
    return countyList;
  }

  // Context accessor ( var backend = BackendProvider.of(context); )
  static BackendProvider of(BuildContext context) =>
      Provider.of<BackendProvider>(context, listen: false);
}
