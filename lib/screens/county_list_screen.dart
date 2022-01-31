import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:provider/provider.dart' show Provider, Consumer;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class CountyListScreen extends StatelessWidget {
  static const path = constants.routeLocations;
  const CountyListScreen({Key? key}) : super(key: key);

  // Refresh parking spot counts for all locations in specified county
  void updateCounty(BuildContext context, String county) async {
    // Store selected county in user's local storage
    final prefs = Provider.of<SharedPreferences>(context, listen: false);
    prefs.setString(constants.prefCounty, county);

    final counties = Counties.of(context);
    final lastCounty = ScreenArguments.of(context)?.lastCounty;

    // If user changed counties, push new screen, else pop back
    var args = ScreenArguments(county: counties[county]);
    if (county != lastCounty) {
      // Request updated parking spot counts
      await counties.refreshParkingCounts(county);
      context.beamToNamed(
          '${constants.routeLocations}/${sanitizeUrl(county)}',
          data: args);
    } else {
      Beamer.of(context).popBeamLocation(data: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const Settings(),
        appBar: const Header(title: Text('Select a County')),
        // If first time running SelectCounty(), call API to get list of supported counties
        body: Center(
            child: Container(
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                child: Consumer<Counties>(builder: (context, counties, child) {
                  return ListView.builder(
                      itemCount: counties.length,
                      itemBuilder: (context, index) {
                        final String county = counties.elementAt(index);
                        return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: TextButton(
                                onPressed: () => updateCounty(context, county),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${county.toUpperCase()} COUNTY',
                                      textScaleFactor: 1.3,
                                    ))));
                      });
                }))));
  }
}
