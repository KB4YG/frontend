import 'package:flutter/material.dart';

class IconKeyTable extends StatelessWidget {
  const IconKeyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SelectableText('Icon Key Table',
              style: Theme.of(context).textTheme.headline6),
        ),
        Table(
          border: TableBorder.symmetric(
              inside: const BorderSide(color: Colors.grey)),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(flex: 1),
            1: FlexColumnWidth(3),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText('Icon', textAlign: TextAlign.center),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    SelectableText('Description', textAlign: TextAlign.center),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.directions_car, color: Colors.blueGrey),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'General parking. The number of non-handicap spots currently'
                    ' available for all the parking lots of a recreation area or'
                    ' individually.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.accessible, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Handicap parking. The number of handicap spots currently '
                    'available.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.local_fire_department),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Fire danger level (low, moderate, high, extreme) for a region'
                    ' as designated by the Oregon Department of Forestry (ODF).'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.pin_drop, color: Colors.red),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Location indicator. Represents a parking lot / recreation '
                    'area access point if on a map.'),
              )
            ])
          ],
        ),
      ],
    );
  }
}
