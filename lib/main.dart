import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/widgets/app.dart';

void main() async {
  // Initialize binding so SharedPreferences can interact with Flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  // Get preferences of user (used for theme and county parking info)
  final prefs = await SharedPreferences.getInstance();
  // Get list of counties from API
  final counties = await Counties.create();
  // Run application
  return runApp(App(prefs: prefs, counties: counties));
}
