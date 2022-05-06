import 'package:beamer/beamer.dart' show BeamPage, BeamPageType, Beamer;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:kb4yg/widgets/screen_template.dart';

import '../../widgets/screen_card.dart';
import 'home_screen_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const path = constants.routeHome;
  static const beamPage = BeamPage(
      key: ValueKey('home'),
      title: 'Home - KB4YG',
      type: BeamPageType.fadeTransition,
      child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
        title: const Text(constants.title),
        child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: kIsWeb ? const WebHomeScreen() : const MobileHomeScreen()));
  }
}

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNarrow = MediaQuery.of(context).size.width <= 600;
    return WebScreenCard(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(children: [
        const HomeScreenCarousel(),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isNarrow ? 14.0 : 40.0, vertical: 30),
            child: SelectableText.rich(
              TextSpan(children: [
                TextSpan(
                    text: isNarrow
                        ? 'Welcome to KB4YG!\n'
                        : 'Welcome to Know Before You Go!\n\n',
                    style: Theme.of(context).textTheme.headline4),
                const TextSpan(
                    text: 'To view parking availability for a natural '
                        'recreation area, press the "View Locations" button '
                        'below and select the county where the natural area '
                        'is located.\n\nDon\'t know which county a '
                        'recreation area is in? No problem! Just select one '
                        'from our map.'),
              ], style: Theme.of(context).textTheme.bodyText1),
            )),
        ElevatedButton(
            child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Text('View Locations', textScaleFactor: 1.1)),
            onPressed: () =>
                Beamer.of(context).beamToNamed(constants.routeLocations))
      ]),
    ));
  }
}

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HomeScreenCarousel(),
      MobileScreenCard(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: SelectableText.rich(TextSpan(children: [
              TextSpan(
                  text: 'Welcome to KB4YG!\n',
                  style: Theme.of(context).textTheme.headline5),
              const TextSpan(
                  text: 'To view parking availability for a natural recreation '
                      'area, press the car icon on the bottom navigation bar '
                      'and select the county where the natural area is '
                      'located.\n\nDon\'t know which county a recreation area '
                      'is in? No problem! Just select one from our map.')
            ], style: Theme.of(context).textTheme.bodyText1))),
      )
    ]);
  }
}
