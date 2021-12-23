import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/counties.dart';
import 'package:kb4yg/screens/loading.dart';
import 'package:kb4yg/screens/select_county.dart';
import 'package:kb4yg/screens/parking_info.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

void main() async {
  // Initialize binding so SharedPreferences can interact with Flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  // Get preferences of user
  final prefs = await SharedPreferences.getInstance();
  final counties = await Counties.create();
  // Run application
  return runApp(LandingPage(
    prefs: prefs,
    counties: counties
  ));
}

class LandingPage extends StatelessWidget {
  final SharedPreferences prefs;
  final Counties counties;
  const LandingPage({Key? key, required this.prefs, required this.counties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if user has select a county during previous app use
    prefs.setString(constants.prefCounty, 'Benton');
    String? selectedCounty = prefs.getString(constants.prefCounty);

    return MaterialApp(
      // TODO: add theme + light/dark mode
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: _decideMainPage(),
      // initialRoute: '/select-county',
      routes: {
        '/': (context) => Loading(
          selectedCounty: selectedCounty,
          counties: counties,
        ),
        constants.navSelectCounty: (context) => SelectCounty(
          prefs: prefs,
          counties: counties
        ),
        constants.navParkingInfo: (context) => const ParkingInfo(),
      },
    );
  }

  // _decideMainPage() {
  //   if (prefs.getBool('has_chosen_county') == true) {
  //     return ParkingInfo();
  //   } else {
  //     return SelectCounty(prefs: prefs);
  //   }
  // }
}

