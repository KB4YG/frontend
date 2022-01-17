import 'package:flutter/material.dart';
import 'package:kb4yg/county.dart';

class ParkingTable extends StatelessWidget {
  final County county;
  const ParkingTable({Key? key, required this.county}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
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
                child: Text(
                  'Location',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      //TODO
                      ),
                ),
              )),
          DataColumn(
              numeric: true,
              tooltip: 'General parking spots currently available',
              label: Icon(Icons.directions_car)),
          DataColumn(
              numeric: true,
              tooltip: 'Handicap parking spots currently available',
              label: Icon(Icons.accessible))
        ],
        rows: [
          for (var loc in county.locs)
            DataRow(
              onSelectChanged: (bool? selected) {
                if (selected == true) {
                  // TODO: add screen for location
                  print(loc.name);
                }
              },
              cells: [
                DataCell(Text(loc.name, textScaleFactor: 1.25)),
                DataCell(Center(
                  child: Text(loc.spots.toString(),
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
    );
  }
}
