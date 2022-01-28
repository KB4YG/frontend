import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/bottom_nav_bar.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: Text('About')),
      endDrawer: const Settings(),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: SelectableText(
                  // TODO: style headers
                  'What is KB4YG?\n\n'
                  'Know Before You Go (KB4YG) is an application available on '
                  'Android, iOS, and the web that displays the amount of parking '
                  'spots available in real-time for a select number of recreation '
                  'areas within Oregon. This allows recreationists to know in advance '
                  'whether there will be parking available before they arrive, '
                  'resulting in saved time and fuel.\n\n'
                  'Currently, only Fitton Green in Benton County is supported. But '
                  'more locations will be added in the future with additional funding.\n\n'
                  'KB4YG was the senior capstone project of eight students at '
                  'Oregon State University during 2021-2022.\n\n'

                  //TODO: get accuracy of backend algorithm
                  'How accurate are the parking spot counts?\n\n'
                  'The method we use to determine available parking (see "How do '
                  'we get this data?") has a X% error rate.\n\n'
                  'How do we get this data?\n\n'
                  'Each parking lot has a camera attached to a computer that takes '
                  'a picture at a fixed interval (which is different for each '
                  'location based on predicted traffic) during the day. This image '
                  'is then analyzed with a computer vision algorithm that counts '
                  'the number of available parking spots, which is then stored in '
                  'our cloud database. The KB4YG application and website draw from '
                  'the most recent entries of this database to display up-to-date '
                  'parking information.',
                  textScaleFactor: 1.3,
                ),
              ),
              TextButton(
                child: const Text('Legal Information', textScaleFactor: 1.2,),
                onPressed: () => showAboutDialog(
                    context: context,
                    applicationVersion: '1.0',
                    // TODO: add KB4YG icon
                    applicationIcon: const Icon(Icons.directions_car_filled),
                    applicationLegalese:
                        'Know Before You Go is licensed under the X license.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
