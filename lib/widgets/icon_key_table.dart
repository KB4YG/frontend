import 'package:flutter/material.dart';

class IconKeyTable extends StatelessWidget {
  const IconKeyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: SelectableText('Icon Key Table'),
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
                child: SelectableText('Key', textAlign: TextAlign.center),
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
                child: Icon(Icons.whatshot),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Fire danger level (low, moderate, high, extreme) for a region'
                    ' as designated by the Oregon Department of Forestry (ODF).'),
              )
            ]),
          ],
        ),
      ],
    );
  }
}
