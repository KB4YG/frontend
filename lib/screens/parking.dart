import 'package:flutter/material.dart';
import 'package:kb4yg/models/counties.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/screens/help.dart';
import 'package:kb4yg/widgets/bottom_nav_bar.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/widgets/fire_safety.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import 'about.dart';

class Parking extends StatefulWidget {
  final County county;
  const Parking({Key? key, required this.county}) : super(key: key);

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  bool refreshed = false;
  // ignore: prefer_typing_uninitialized_variables
  late var countyChanged;
  var refreshedCounty = Counties();
//
  void pushSelectCounty(BuildContext context) {
    // Prompt user with SelectCounty() screen
    Navigator.pushNamed(context, constants.routeParking,
        arguments: ScreenArguments(county: widget.county));
  }

  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 2));

    await widget.county.refreshParkingCounts("${widget.county}");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Settings(),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: TextButton.icon(
            icon: const Icon(Icons.edit_location),
            label: Text('${widget.county} County',
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              pushSelectCounty(context);
            },
          )),
      bottomNavigationBar: const BottomNavBar(navIndex: 0),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              // const Text('Parking Information'), // TODO: add styling
              ParkingTable(county: widget.county),
              FireSafety(county: widget.county)
            ]),
          ),
        ),
      ),
    );
  }
}
