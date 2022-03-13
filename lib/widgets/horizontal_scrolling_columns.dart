// import 'package:flutter/material.dart';

// class HorizontalScrollingColumns extends StatelessWidget {
//   const HorizontalScrollingColumns({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columnSpacing: 30.0,
//           columns: dataColumns(),
//           rows: dataRows(),
//         ),
//       ),
//     );
//   }
// }

// List<DataColumn> dataColumns() {
//   List<DataColumn> dataColumns = [
//     const DataColumn(
//       label: Icon(
//         Icons.drive_eta,
//       ),
//     ),
//     const DataColumn(
//       label: Icon(
//         Icons.accessible,
//       ),
//     ),
//     const DataColumn(
//       label: Icon(Icons.place, color: Colors.red),
//     ),
//   ];
//   return dataColumns;
// }

// List<DataRow> dataRows() {
//   List<DataRow> dataRow = [
//     DataRow(
//       cells: <DataCell>[
//         DataCell(Text('Lot B')),
//         const DataCell(Text('Sarah')),
//         const DataCell(Text('19')),
//         DataCell(TextButton.icon(
//           onPressed: () => {}, //launchMap(context, ), //TODO
//           icon: const Icon(
//             Icons.directions,
//           ),
//           label: const Text('Maps', textAlign: TextAlign.center),
//           style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all(Colors.white),
//               backgroundColor: MaterialStateProperty.all(Colors.blue)),
//         )),
//       ],
//     ),
//     const DataRow(
//       cells: <DataCell>[
//         DataCell(Text('Lot B')),
//         DataCell(Text('Janine')),
//         DataCell(Text('43')),
//         DataCell(Text('Professor')),
//       ],
//     ),
//     const DataRow(
//       cells: <DataCell>[
//         DataCell(Text('Lot C')),
//         DataCell(Text('William')),
//         DataCell(Text('27')),
//         DataCell(Text('Associate Professor')),
//       ],
//     ),
//   ];
//   return dataRow;
// }
