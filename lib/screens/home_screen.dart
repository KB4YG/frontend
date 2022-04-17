import 'package:beamer/beamer.dart' show BeamPage, BeamPageType, Beamer;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/screen_template.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const HomeScreenCarousel(),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width > 600)
                          ? 40.0
                          : 12.0,
                      vertical: 30),
                  child: SelectableText.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'Welcome to Know Before You Go!\n\n',
                          style:
                              kIsWeb && MediaQuery.of(context).size.width > 600
                                  ? Theme.of(context).textTheme.headline4
                                  : Theme.of(context).textTheme.headline5),
                      const TextSpan(
                          text: 'To view parking availability for a natural '
                              'recreation area, press the '),
                      kIsWeb
                          ? const TextSpan(
                              text: '"View Locations" button below ')
                          : const TextSpan(
                              text: 'car icon on the bottom navigation bar '),
                      const TextSpan(
                          text:
                              'and select the county where the natural area is '
                              'located.\n\nDon\'t know which county a '
                              'recreation area is in? No problem! Just '
                              'select one from our map.'),
                    ], style: Theme.of(context).textTheme.bodyText1),
                  )),
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
    AssetImage('assets/images/fitton-green-2.jpg'),
    AssetImage('assets/images/fitton-green-1.jpg'),
    AssetImage('assets/images/fitton-green-3.jpg')
  ];
  static const List<String> carouselText = [
    'Fitton Green',
    'Fitton Green',
    'Fitton Green'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 20),
            enlargeCenterPage: true,
          ),
          itemCount: images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0),
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                                image: images[itemIndex]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SelectableText(
                        carouselText[itemIndex],
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.caption?.fontSize),
                      ),
                    ],
                  )),
    );
  }
}
