import 'package:flutter/material.dart';
import 'package:kb4yg/counties.dart';
import 'package:kb4yg/access_point.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCounty extends StatelessWidget {
  // Single instance of all supported counties, static -> call API only once
  // when SelectCounty is first initialized
  final Counties counties;
  final SharedPreferences prefs;
  const SelectCounty({required this.prefs, required this.counties, Key? key}) : super(key: key);

  // Refresh parking spot counts for all locations in specified county
  // firstRun specifies whether to push & replace (true) or pop (false) screen
  void updateCounty(BuildContext context, String county, bool firstRun) async {
    // Store selected county in user's local storage
    prefs.setString(constants.prefCounty, county);
    // Request updated parking spot counts
    await counties.refreshParkingCounts(county);
    // Push (if first run) or pop to parking-info
    ScreenArguments args = ScreenArguments(county: county,
        locations: List<AccessPoint>.from(counties[county])
    );
    // Display ParkingInfo() screen
    if (firstRun) {
      Navigator.pushReplacementNamed(context, constants.navParkingInfo, arguments: args);
    } else {
      Navigator.pop(context, args);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get selected county from previous screen if one was specified
    String? selectedCounty = (ModalRoute.of(context)!.settings.arguments as ScreenArguments).county;

    return Scaffold(
      endDrawer: const Settings(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Select a County'),
        centerTitle: true,
        leading: (ModalRoute.of(context)?.canPop ?? false) ? const BackButton() : null
      ),
      // If first time running SelectCounty(), call API to get list of supported counties
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
          child: ListView.builder(
            itemCount: counties.length(),
            itemBuilder: (context, index) {
              final String county = counties.elementAt(index);
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => updateCounty(context, county, selectedCounty == null),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${county.toUpperCase()} COUNTY',
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}