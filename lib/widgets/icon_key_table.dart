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
                child: Icon(Icons.directions_car),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'General parking. The number of non-handicap '
                    'spots currently available.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.accessible),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Handicap parking. The number of handicap spots '
                    'currently available.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle_outline, color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Fire danger low. According to our wildfire data '
                    'source, there are no fires within 10 miles of a '
                    'recreation area for a given county.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.warning_amber_rounded, color: Colors.amber),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText('Fire danger medium. According to our '
                    'wildfire data source, there is a fire within 10 '
                    'miles of a recreation area for a given county.'),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.warning, color: Colors.red),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectableText(
                    'Fire danger high. According to our wildfire data '
                    'source, there is a fire within 5 miles of a '
                    'recreation area for a given county.'),
              )
            ])
          ],
        ),
      ],
    );
  }
}
