import 'package:beamer/beamer.dart' show BeamPage, Beamer;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';


class HomeScreen extends StatelessWidget {
  static const path = constants.routeHome;
  static const beamPage = BeamPage(
      key: ValueKey('home'), title: 'Home - KB4YG', child: HomeScreen());
  static const List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'
  ];

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: Text(constants.title)),
      endDrawer: const Settings(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 130, 30),
        child: FloatingActionButton.extended(
            hoverColor: Colors.orange,
            onPressed: () {
              Beamer.of(context).beamToNamed(constants.routeLocations);
            },
            label: const Text('Let\'s begin')),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 600),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            itemCount: urls.length,
            itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(urls[itemIndex]),
                    ),
                  ),
                )),
        ),
      ),
    );
  }
}
