import 'package:flutter/material.dart';

class RecreationAreaInfo extends StatelessWidget {
  final String description;

  const RecreationAreaInfo(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
          child: const Text('About',
              textScaleFactor: 1.15,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Divider(thickness: 2),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SelectableText(
            description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }
}