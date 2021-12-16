import 'package:flutter/material.dart';
import 'package:kb4yg/screens/loading.dart';
import 'package:kb4yg/screens/select_county.dart';
import 'package:kb4yg/screens/parking_info.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/select_county',
  routes: {
    '/': (context) => Loading(),
    '/select_county': (context) => SelectCounty(),
    '/parking_info': (context) => ParkingInfo(),
  },
));
