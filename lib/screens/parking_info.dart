import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/settings.dart';


class ParkingInfo extends StatefulWidget {
  const ParkingInfo({Key? key}) : super(key: key);

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {

  static const tableTitle = 'Parking Information';
  Map data = {};

  void pushSelectCounty () async {
    // Prompt user with SelectCounty() screen
    dynamic result = await Navigator.pushNamed(
        context,
        constants.navSelectCounty,
        arguments: ScreenArguments(
            county: data[argCounty],
            locations: data[argLocations]
        )
    );
    // Update state with new county (if user selected one)
    if (result != null) {
      setState(() {
        data = {argCounty: result.county, argLocations: result.locations};
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // Get screen width for table margin percentage
    final double width = MediaQuery.of(context).size.width;

    // Update data if first time running
    if (data.isEmpty) {
      final settings = ModalRoute.of(context)?.settings;
      if (settings?.arguments != null) {
        final args = settings!.arguments as ScreenArguments;
        data = {argCounty: args.county, argLocations: args.locations};
      }
    }

    return Scaffold(
      endDrawer: const Settings(),
      appBar: AppBar(
        // backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
        title: TextButton.icon(
          icon: const Icon(Icons.edit_location),
          label: Text(
            '${data[argCounty]} County',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: pushSelectCounty,
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Parking table title
              // TODO: add styling
              const Text(tableTitle),
              // Parking information table
              // TODO: turn into widget
              Container(
                // color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: width * 0.05),
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
                child: DataTable(
                  // TODO: add ability to sort columns
                  columnSpacing: 45,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(
                      tooltip: 'Name of recreation area',
                      label: Expanded(
                        child: Text('Location',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            //TODO
                          ),
                        ),
                      )
                    ),
                    DataColumn(
                      numeric: true,
                      tooltip: 'General parking spots currently available',
                      label: Icon(Icons.directions_car)
                    ),
                    DataColumn(
                      numeric: true,
                      tooltip: 'Handicap parking spots currently available',
                      label: Icon(Icons.accessible)
                    )
                  ],
                  rows: [
                    // Parking Information
                    for (var loc in data[argLocations]) DataRow(
                      onSelectChanged: (bool? selected) {
                        if (selected == true) {
                          // TODO: add screen for location
                          print(loc.name);
                        }},
                      cells: [
                        DataCell(Text(
                          loc.name,
                          textScaleFactor: 1.25
                          // style: TextStyle(fontSize: 25),
                        )),
                        DataCell(Center(
                          child: Text(
                              loc.spots.toString(),
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Center(
                          child: Text(
                            loc.handicap.toString(),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    ]),
                  ]),
              ),
          ]),
        ),
      ),
    );
  }
}