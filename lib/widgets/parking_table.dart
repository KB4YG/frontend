import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';

import '../models/recreation_area.dart';
import '../utilities/hyperlink.dart';

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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20), // Fire danger info
                child: DataTable(
                  sortColumnIndex: _columnIndex,
                  sortAscending: _isAscending,
                  showCheckboxColumn: false,
                  columnSpacing: 16,
                  columns: [
                    DataColumn(
                        onSort: onSort,
                        tooltip: 'Name of recreation area',
                        label: const Expanded(
                          child: Text(
                            // Allow more room on smaller screens
                            kIsWeb ? 'Recreation Area' : 'Location',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.4,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                    DataColumn(
                        onSort: onSort,
                        numeric: true,
                        tooltip: 'General parking spots currently available',
                        label: const Padding(
                          padding: EdgeInsets.only(right: 14.0),
                          child: Icon(Icons.directions_car,
                              color: Colors.blueGrey),
                        )),
                    DataColumn(
                        onSort: onSort,
                        numeric: true,
                        tooltip:
                            'Handicap-accessible parking spots currently available',
                        label: const Padding(
                          padding: EdgeInsets.only(right: 14.0),
                          child:
                              Icon(Icons.accessible, color: Colors.lightBlue),
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
                          DataCell(Text(loc.name,
                              style: const TextStyle(color: Colors.lightBlue),
                              textScaleFactor: 1.2)),
                          DataCell(Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                    loc.spots == -1
                                        ? 'n/a'
                                        : loc.spots.toString(),
                                    textAlign: TextAlign.center)),
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
                        ],
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  tooltip: 'Fire Danger Info',
                  icon: const Icon(Icons.info_outline, color: Colors.blue),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Fire Danger Level'),
                      content: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                            text:
                                'The displayed fire danger level is designated by the '),
                        Hyperlink(
                            text: 'Oregon Department of Forestry (ODF)',
                            url:
                                'https://gisapps.odf.oregon.gov/firerestrictions/PFR.html'),
                        const TextSpan(
                            text:
                                '.\n\nTo sign up for real-time alerts or stay informed about Oregon wildfire, visit '),
                        Hyperlink(text: 'https://wildfire.oregon.gov/'),
                        const TextSpan(text: '.')
                      ])),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
