import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';


class ParkingTable extends StatefulWidget {
  final County county;
  const ParkingTable({Key? key, required this.county}) : super(key: key);

  @override
  State<ParkingTable> createState() => _ParkingTableState();
}

class _ParkingTableState extends State<ParkingTable> {
  int _columnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
      child: DataTable(
        sortColumnIndex: _columnIndex,
        sortAscending: _isAscending,
        showCheckboxColumn: false,
        columns: [
          DataColumn(
            onSort: onSort,
            tooltip: 'Name of recreation area',
            label: const Expanded(
              child: Text(
                'Location',
                textAlign: TextAlign.center,
                textScaleFactor: 1.4,
                // TODO: text style
              ),
            )),
          DataColumn(
            onSort: onSort,
            numeric: true,
            tooltip: 'General parking spots currently available',
            label: const Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(Icons.directions_car),
            )),
          DataColumn(
            onSort: onSort,
            numeric: true,
            tooltip: 'Handicap-accessible parking spots currently available',
            label: const Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(Icons.accessible),
            ))
        ],
        rows: [
          for (var loc in widget.county.locs)
            DataRow(
              onSelectChanged: (bool? selected) {
                if (selected == true) {
                  String route = constants.routeLocations;
                  route += sanitizeUrl('/${widget.county.name}/${loc.name}');
                  Beamer.of(context).beamToNamed(route);
                }
              },
              cells: [
                DataCell(Text(loc.name, textScaleFactor: 1.25)),
                DataCell(Center(
                  child: Text(
                    loc.spots.toString(),
                    textAlign: TextAlign.center),
                )),
                DataCell(Center(
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
                      pushLocationScreen(context, loc);
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

  void onSort(int columnIndex, bool isAscending) {
    switch (columnIndex) {
      case 0:
        isAscending == true
          ? widget.county.locs.sort((loc1, loc2) => loc1.name.compareTo(loc2.name))
          : widget.county.locs.sort((loc1, loc2) => loc2.name.compareTo(loc1.name));
        break;
      case 1:
        isAscending == true
          ? widget.county.locs.sort((loc1, loc2) => loc1.spots.compareTo(loc2.spots))
          : widget.county.locs.sort((loc1, loc2) => loc2.spots.compareTo(loc1.spots));
        break;
      case 2:
        isAscending == true
          ? widget.county.locs.sort((loc1, loc2) => loc1.handicap.compareTo(loc2.handicap))
          : widget.county.locs.sort((loc1, loc2) => loc2.handicap.compareTo(loc1.handicap));
        break;
    }
    setState(() {
      _columnIndex = columnIndex;
      _isAscending = isAscending;
    });
  }
}
