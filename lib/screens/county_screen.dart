import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/widgets/fire_safety.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';

class CountyScreen extends StatefulWidget {
  final County county;
  const CountyScreen({Key? key, required this.county}) : super(key: key);

  @override
  State<CountyScreen> createState() => _CountyScreenState();
}

class _CountyScreenState extends State<CountyScreen> {
  Future _pullRefresh() async {
    // TODO: ensure responsive UX
    //await Future.delayed(Duration(seconds: 2));
    await widget.county.refreshParking();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: TextButton.icon(
        icon: const Icon(Icons.edit_location),
        label: Text('${widget.county.name} County',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () {
          Beamer.of(context).beamToNamed(constants.routeLocations,
              data: ScreenArguments(county: widget.county));
        },
      )),
      endDrawer: const Settings(),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              ParkingTable(county: widget.county),
              FireSafety(county: widget.county)
            ]),
          ),
        ),
      ),
    );
  }
}
