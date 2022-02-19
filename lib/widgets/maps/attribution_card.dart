import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/launch_url.dart';

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
              TextSpan(
                  style: const TextStyle(color: Colors.blue),
                  text: 'OpenStreetMap',
                  mouseCursor: SystemMouseCursors.click,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchURL(attributionLink)),
              const TextSpan(text: ' contributors')
            ]),
          ),
        ),
      ),
    );
  }
}