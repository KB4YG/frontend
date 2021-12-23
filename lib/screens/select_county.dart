import 'package:flutter/material.dart';
import 'package:kb4yg/counties.dart';
import 'package:kb4yg/access_point.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class SelectCounty extends StatefulWidget {
  // Single instance of all supported counties, static -> call API only once
  // when SelectCounty is first initialized
  final SharedPreferences prefs;
  final Counties counties;
  const SelectCounty({required this.prefs, required this.counties, Key? key}) : super(key: key);
  // final SharedPreferences prefs;
  // const SelectCounty({Key? key, required this.prefs}) : super(key: key);

  @override
  State<SelectCounty> createState() => _SelectCountyState();
}

class _SelectCountyState extends State<SelectCounty> {
  // static String? selectedCounty;

  // Refresh parking spot counts for all locations in specified county
  // firstRun specifies whether to push & replace (true) or pop (false) screen
  void updateCounty(String county, bool firstRun) async {
    // Store selected county in user's local storage
    widget.prefs.setString(constants.prefCounty, county);
    // Request updated parking spot counts
    await widget.counties.refreshParkingCounts(county);
    // Push (if first run) or pop to parking-info
    ScreenArguments args = ScreenArguments(county: county,
        locations: List<AccessPoint>.from(widget.counties[county])
    );
    // Display ParkingInfo() screen
    if (firstRun) {
      // selectedCounty = county;
      Navigator.pushReplacementNamed(context, constants.navParkingInfo, arguments: args);
    } else {
      Navigator.pop(context, args);
    }
  }

  @override

  @override
  Widget build(BuildContext context) {
    // Get selected county from previous screen if one was specified
    String? selectedCounty = ModalRoute.of(context)?.settings.arguments == null ?
      null : (ModalRoute.of(context)?.settings.arguments as ScreenArguments).county;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Select a County'),
        centerTitle: true,
      ),
      // If first time running SelectCounty(), call API to get list of supported counties
      body: ListView.builder(
              itemCount: widget.counties.length(),
              itemBuilder: (context, index) {
                final String county = widget.counties.elementAt(index);
                return Card(
                  // TODO: set max width of county card for larger displays
                  margin: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      updateCounty(county, selectedCounty == null);
                    },
                    child: Text(
                      '${county.toUpperCase()} COUNTY',
                      textScaleFactor: 1.2,
                    ),
                  ),
                );
              },
              // icon: Icon(Icons.edit_location),
            )
    );
  }
}
