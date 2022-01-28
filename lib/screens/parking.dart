import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/widgets/fire_safety.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';

class CountyDetailsScreen extends StatelessWidget {
  final County county;
  const CountyDetailsScreen({Key? key, required this.county}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          title: TextButton.icon(
            icon: const Icon(Icons.edit_location),
            label: Text('${county.name} County',
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              Beamer.of(context).beamToNamed(
                  constants.routeLocations,
                  data: ScreenArguments(county: county)
              );
            },
          )),
      endDrawer: const Settings(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            ParkingTable(county: county),
            FireSafety(county: county)
          ]),
        ),
      ),
    );
  }
}
