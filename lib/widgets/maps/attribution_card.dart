import 'package:flutter/material.dart';

import '../../utilities/hyperlink.dart';

class AttributionCard extends StatelessWidget {
  static const attributionLink = 'https://www.openstreetmap.org/copyright';
  const AttributionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: attributionLink,
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: '© '),
              Hyperlink(text: 'OpenStreetMap', url: attributionLink),
              const TextSpan(text: ' contributors')
            ]),
          ),
        ),
      ),
    );
  }
}