import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/parking_lot.dart';

class ParkingLotTable extends StatefulWidget {
  final List<ParkingLot> parkingLots;

  const ParkingLotTable({Key? key, required this.parkingLots})
      : super(key: key);

  @override
  State<ParkingLotTable> createState() => _ParkingLotTableState();
}

class _ParkingLotTableState extends State<ParkingLotTable> {
  DateTime get dt => widget.parkingLots[0].dt;
  late final DateFormat formatter;

  @override
  void initState() {
    super.initState();
    formatter = DateFormat('MM/dd/yyyy @ hh:mm a');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(columnSpacing: 40, columns: const [
          DataColumn(
            label: Expanded(
              child: Text(
                'Parking Lot',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataColumn(label: Icon(Icons.drive_eta)),
          DataColumn(label: Icon(Icons.accessible, color: Colors.blue)),
          DataColumn(
              label: Expanded(
                  child: Center(child: Icon(Icons.place, color: Colors.red)))),
        ], rows: [
          for (var lot in widget.parkingLots)
            DataRow(
              cells: [
                DataCell(
                    Center(child: Text(lot.name, textAlign: TextAlign.center))),
                DataCell(Center(
                    child: Text(lot.spotsStr, textAlign: TextAlign.center))),
                DataCell(Center(
                    child: Text(lot.handicapStr, textAlign: TextAlign.center))),
                DataCell(Center(
                  child: ElevatedButton.icon(
                      onPressed: () => MapsLauncher.launchQuery(lot.address),
                      icon: const Icon(Icons.assistant_direction),
                      label: const Text('Map')),
                ))
              ],
            )
        ]),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Updated: ${formatter.format(dt)}',
              textScaleFactor: 1.2,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontStyle: FontStyle.italic),
            ))
      ],
    );
  }
}
