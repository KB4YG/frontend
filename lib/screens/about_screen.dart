import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:flutter/material.dart';
import 'package:kb4yg/constants.dart' show routeAbout, appVersion;
import 'package:kb4yg/widgets/logo.dart';
import 'package:kb4yg/widgets/screen_card.dart';

import '../widgets/screen_template.dart';

class AboutScreen extends StatelessWidget {
  static const path = routeAbout;
  static const beamPage = BeamPage(
      key: ValueKey('about'),
      title: 'About - KB4YG',
      type: BeamPageType.fadeTransition,
      child: AboutScreen());

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: const Text('About'),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ScreenCard(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: 'What is KB4YG?\n\n',
                        style: Theme.of(context).textTheme.headline6),
                    const TextSpan(
                        text:
                            'Know Before You Go (KB4YG) is an application available on '
                            'Android, iOS, and the web that displays the amount of parking '
                            'spots available in real-time for a select number of recreation '
                            'areas within Oregon. This allows recreationists to know in advance '
                            'whether there will be parking available before they arrive, '
                            'resulting in saved time and fuel.\n\n'
                            'Currently, only Fitton Green in Benton County is supported. '
                            'More locations will be added in the future with additional funding.\n\n'
                            'KB4YG was the senior capstone project of eight students at '
                            'Oregon State University during 2021-2022.\n\n'),
                    TextSpan(
                        text: '\nHow accurate are the parking spot counts?\n\n',
                        style: Theme.of(context).textTheme.headline6),
                    const TextSpan(
                        text:
                            'The method we use to determine available parking (see "How do '
                            'we get this data?") is approximately 60-70% accurate. \n\n'),
                    TextSpan(
                        text: '\nHow do we get this data?\n\n',
                        style: Theme.of(context).textTheme.headline6),
                    const TextSpan(
                      text:
                          'Each parking lot has a camera attached to a computer that takes '
                          'a picture at a fixed interval (which is different for each '
                          'location based on predicted traffic) during the day. This image '
                          'is then analyzed with a computer vision algorithm that counts '
                          'the number of available parking spots. The KB4YG application and '
                           'website then display this up-to-date parking information.',
                    ),
                  ], style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: Text(
                      'License Information',
                      textScaleFactor: 1.1,
                    ),
                  ),
                  onPressed: () => showAboutDialog(
                      context: context,
                      applicationVersion: appVersion,
                      applicationIcon: const Logo(),
                      applicationLegalese:
                          'This project is licensed under the terms of the MIT license.'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
