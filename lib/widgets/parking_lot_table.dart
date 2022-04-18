import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ParkingLotTable extends StatefulWidget {
  const ParkingLotTable({Key? key, required this.parkingLots})
      : super(key: key);

  final List parkingLots;

  @override
  State<ParkingLotTable> createState() => _ParkingLotTableState();
}

class _ParkingLotTableState extends State<ParkingLotTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: MediaQuery.of(context).size.width / 15,
      columns: dataColumns(widget.parkingLots),
      rows: dataRows(widget.parkingLots),
    );
  }

  List<DataColumn> dataColumns(parkingLots) {
    List<DataColumn> dataColumns = [
      const DataColumn(
        label: Text(
          'Parking Lot',
        ),
      ),
      const DataColumn(
        label: Icon(
          Icons.drive_eta,
        ),
      ),
      const DataColumn(
        label: Icon(
          Icons.accessible,
          color: Colors.blue,
        ),
      ),
      DataColumn(
          label: Row(children: const [
        Text('       '),
        Icon(
          Icons.place,
          color: Colors.red,
        ),
      ])),
    ];

    return dataColumns;
  }

  List<DataRow> dataRows(parkingLots) {
    List<DataRow> dataRow = [];

    parkingLots.forEach((lot) {
      dataRow.add(DataRow(
        cells: <DataCell>[
          DataCell(
            Text(lot.name),
            onDoubleTap: () {},
          ),
          DataCell(Text(" ${lot.spots.toString()}")),
          DataCell(Text("  ${lot.handicap.toString()}")),
          DataCell(Container(
            width: 85,
            height: 30,
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
                onPressed: () {
                  MapsLauncher.launchQuery(lot.address);
                },
                icon: const Icon(
                  Icons.assistant_direction,
                ),
                label: const Text("Map"),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 11),
                )),
          )),
        ],
      ));
    });

    return dataRow;
  }
}
