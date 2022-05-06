import 'package:beamer/beamer.dart' show BeamPage, BeamPageType, Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:kb4yg/widgets/screen_card.dart';
import 'package:kb4yg/widgets/screen_template.dart';

class NotFoundScreen extends StatelessWidget {
  static const beamPage = BeamPage(
      key: ValueKey('404'),
      title: 'Page Not Found - KB4YG',
      type: BeamPageType.fadeTransition,
      child: NotFoundScreen());

  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
        title: const Text(constants.title),
        child: ScreenCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: 'Page Not Found\n\n',
                            style: Theme.of(context).textTheme.headline4),
                        const TextSpan(
                            text:
                                "Uh oh, we can't seem to find the page you're looking for.\n\n"
                                "Try navigating to the previous page or use the button below to go to the home screen."),
                      ], style: Theme.of(context).textTheme.bodyText1),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                      onPressed: () =>
                          Beamer.of(context).beamToNamed(constants.routeHome),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        child: Text('Return Home', textScaleFactor: 1.1),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
