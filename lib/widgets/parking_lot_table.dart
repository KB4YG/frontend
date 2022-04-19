import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ParkingLotTable extends StatelessWidget {
  final List parkingLots;
  final String? timestamp;

  const ParkingLotTable({Key? key, required this.parkingLots, this.timestamp})
      : super(key: key);

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
          for (var lot in parkingLots)
            DataRow(
              cells: [
                DataCell(
                    Center(child: Text(lot.name, textAlign: TextAlign.center))),
                DataCell(Center(
                    child: Text(lot.spots.toString(),
                        textAlign: TextAlign.center))),
                DataCell(Center(
                    child: Text(lot.handicap.toString(),
                        textAlign: TextAlign.center))),
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
            child: timestamp == null
                ? null
                : Text(
                    timestamp!,
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
