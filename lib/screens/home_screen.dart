import 'package:beamer/beamer.dart' show BeamPage, BeamPageType, Beamer;
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
        hasScrollbar: false,
        title: const Text(constants.title), // Screen title
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Card(
                  elevation: 10.0,
                  shadowColor: Colors.white,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 180,
                    child: Column(
                      children: const [
                        HomeScreenCarousel(),
                        InfromationBody(),
                      ],
                    ),
                  ),
                ),
              ),
              if (kIsWeb) // button for the web version of the app
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

// Send data to the carousel widget
class HomeScreenCarousel extends StatelessWidget {
  const HomeScreenCarousel({Key? key}) : super(key: key);
  // Asset images
  static const List<String?> assetImageList = [
    'assets/images/fitton-green-1.jpg',
    'assets/images/fitton-green-2.jpg',
    'assets/images/fitton-green-3.jpg'
  ];
  // images label
  static List<String?> urlImageList = [];
  static List<String?> areaNameList = [
    'Fitton Green',
    'Fitton Green',
    'Fitton Green'
  ];
  static String? areaName;
  @override
  Widget build(BuildContext context) {
    return Carousel(
        urlImageList: urlImageList,
        assetImageList: assetImageList,
        areaNameList: areaNameList,
        areaName: areaName);
  }
}

// Introduction body for home screen
class InfromationBody extends StatelessWidget {
  const InfromationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: SelectableText(
        kIsWeb // Intro body for the Web or Mobile app
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
        style: const TextStyle(fontSize: 17.0, height: 1.3, letterSpacing: 0.5),
      ),
    );
  }
}
