import 'package:beamer/beamer.dart' show BeamPage, BeamPageType, Beamer;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/screen_template.dart';
import 'package:kb4yg/widgets/carousel.dart';

class HomeScreen extends StatelessWidget {
  static const path = constants.routeHome;
  static const beamPage = BeamPage(
      key: ValueKey('home'),
      title: 'Home - KB4YG',
      type: BeamPageType.fadeTransition,
      child: HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
        title: const Text(constants.title),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const HomeScreenCarousel(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: SelectableText(
                  kIsWeb
                      ? 'Welcome to Know Before You Go! '
                          'To view parking availability for a natural recreation area, '
                          'press the "View Locations" button below and select the county '
                          'where the natural area is located.\n\nDon\'t know which county '
                          'a recreation area is in? No problem! Just select one from our map.'
                      : 'Welcome to the Know Before You Go App!\n\n'
                          'To view parking availability for a natural recreation area, '
                          'press the car icon on the bottom navigation bar and select the county '
                          'where the natural area is located.\n\nDon\'t know which county '
                          'a recreation area is in? No problem! Just select one from our map.',
                  style: const TextStyle(
                      fontSize: 17.0, height: 1.3, letterSpacing: 0.5),
                ),
              ),
              if (kIsWeb)
                ElevatedButton(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: Text(
                      'View Locations',
                      textScaleFactor: 1.1,
                    ),
                  ),
                  onPressed: () {
                    Beamer.of(context).beamToNamed(constants.routeLocations);
                  },
                )
            ],
          ),
        ));
  }
}

class HomeScreenCarousel extends StatelessWidget {
  const HomeScreenCarousel({Key? key}) : super(key: key);

  static const List<AssetImage> images = [
    AssetImage('assets/images/fitton-green-1.jpg'),
    AssetImage('assets/images/fitton-green-2.jpg'),
    AssetImage('assets/images/fitton-green-3.jpg')
  ];
  static const List<String> carouselText = [
    'Fitton Green',
    'Fitton Green',
    'Fitton Green'
  ];

  @override
  Widget build(BuildContext context) {
    return Carousel(images: images, carouselText: carouselText);
  }
}
