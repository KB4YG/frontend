import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';

import '../models/recreation_area.dart';

class ParkingTable extends StatefulWidget {
  final County county;
  final Future<void> Function() onRefresh;
  const ParkingTable({Key? key, required this.county, required this.onRefresh})
      : super(key: key);

  @override
  State<ParkingTable> createState() => _ParkingTableState();
}

class _ParkingTableState extends State<ParkingTable> {
  List<RecreationArea> get locations => widget.county.recreationAreas;
  int _columnIndex = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    onSort(0, _isAscending);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 550),
          child: Column(children: [
            DataTable(
                sortColumnIndex: _columnIndex,
                sortAscending: _isAscending,
                showCheckboxColumn: false,
                columnSpacing: 16,
                headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.grey[200]),
                columns: [
                  DataColumn(
                      onSort: onSort,
                      tooltip: 'Name of recreation area',
                      label: Expanded(
                        child: Text(
                          kIsWeb ? 'Recreation Area' : 'Location',
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
                        child:
                            Icon(Icons.directions_car, color: Colors.blueGrey),
                      )),
                  DataColumn(
                      onSort: onSort,
                      numeric: true,
                      tooltip:
                          'Handicap-accessible parking spots currently available',
                      label: const Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.accessible, color: Colors.lightBlue),
                      )),
                  DataColumn(
                      onSort: onSort,
                      numeric: true,
                      tooltip: 'ODF Designated Fire Danger Level',
                      label: Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.local_fire_department,
                            color: widget.county.fireDanger.color),
                      ))
                ],
                rows: [
                  for (var loc in locations)
                    DataRow(
                        onSelectChanged: (bool? selected) {
                          if (selected == true) {
                            String route = constants.routeLocations;
                            route += sanitizeUrl(loc.parkingLotUrl);
                            Beamer.of(context).beamToNamed(route);
                          }
                        },
                        cells: [
                          DataCell(Text(
                            loc.name,
                            textScaleFactor: 1.25,
                            style: const TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.blue, offset: Offset(0, -2))
                                ],
                                color: Colors.transparent,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue),
                          )),
                          DataCell(Center(
                            child: Text(
                              loc.spots == -1 ? 'n/a' : loc.spots.toString(),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataCell(Center(
                            child: Text(
                                loc.handicap == -1
                                    ? 'n/a'
                                    : loc.handicap.toString(),
                                textAlign: TextAlign.center),
                          )),
                          DataCell(Center(
                              child: Text(loc.fireDanger.toString(),
                                  style: TextStyle(color: loc.fireDanger.color),
                                  textAlign: TextAlign.center))),
                        ]),
                ]),
          ]),
        ),
      ),
    );
  }

  void onSort(int columnIndex, bool isAscending) {
    switch (columnIndex) {
      case 0:
        isAscending == true
            ? locations.sort((loc1, loc2) => loc1.name.compareTo(loc2.name))
            : locations.sort((loc1, loc2) => loc2.name.compareTo(loc1.name));
        break;
      case 1:
        isAscending == true
            ? locations.sort((loc1, loc2) => loc1.spots.compareTo(loc2.spots))
            : locations.sort((loc1, loc2) => loc2.spots.compareTo(loc1.spots));
        break;
      case 2:
        isAscending == true
            ? locations
                .sort((loc1, loc2) => loc1.handicap.compareTo(loc2.handicap))
            : locations
                .sort((loc1, loc2) => loc2.handicap.compareTo(loc1.handicap));
        break;
      case 3:
        isAscending == true
            ? locations.sort((loc1, loc2) => loc1.fireDanger.level.index
                .compareTo(loc2.fireDanger.level.index))
            : locations.sort((loc1, loc2) => loc2.fireDanger.level.index
                .compareTo(loc1.fireDanger.level.index));
        break;
    }
    setState(() {
      _columnIndex = columnIndex;
      _isAscending = isAscending;
    });
  }
}
