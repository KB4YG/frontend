import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/screens/help.dart';
import 'package:kb4yg/widgets/bottom_nav_bar.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/widgets/fire_safety.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import 'about.dart';

class Parking extends StatelessWidget {
  final County county;
  const Parking({Key? key, required this.county}) : super(key: key);
//
//   @override
//   State<Parking> createState() => _ParkingState();
// }
//
// class _ParkingState extends State<Parking> {
//   int _selectedIndex = 0;
//   get county => widget.county;
//   late final List<Widget> _screens;

  // @override
  // void initState() {
  //   super.initState();
  //   _screens = [
  //     SingleChildScrollView(
  //       child: Center(
  //         child: Column(
  //             children: [
  //               // const Text('Parking Information'), // TODO: add styling
  //               ParkingTable(county: county),
  //               FireSafety(county: county)
  //             ]),
  //       ),
  //     ),
  //     const About(navBarIndex: 0),
  //     const Help(loc_name: '', navBarIndex: 0),
  //   ];
  // }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void pushSelectCounty(BuildContext context) {
    // Prompt user with SelectCounty() screen
    Navigator.pushNamed(context, constants.routeParking,
        arguments: ScreenArguments(county: county));
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
            label: Text('$county County',
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              pushSelectCounty(context);
            },
          )),
      bottomNavigationBar: const BottomNavBar(navIndex: 0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            // const Text('Parking Information'), // TODO: add styling
            ParkingTable(county: county),
            FireSafety(county: county)
          ]),
        ),
      ),
    );
  }
}
