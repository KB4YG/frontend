import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' show routeHelp;
import 'package:kb4yg/widgets/content_card.dart';
import 'package:kb4yg/widgets/icon_key_table.dart';
import 'package:kb4yg/widgets/screen_template.dart';

class HelpScreen extends StatelessWidget {
  static const path = routeHelp;
  static const beamPage = BeamPage(
      key: ValueKey('help'),
      title: 'Help - KB4YG',
      type: BeamPageType.fadeTransition,
      child: HelpScreen());

  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: const Text('Help'),
      child: ScreenCard(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(maxWidth: 700),
          child: const IconKeyTable(),
        ),
      ),
    );
  }
}
