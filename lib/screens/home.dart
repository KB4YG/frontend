import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

class Home extends StatelessWidget {
  static const List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'
  ];

  const Home({Key? key}) : super(key: key);

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
              Navigator.pushNamed(context, constants.routeParking,
                  arguments: ScreenArguments());
            },
            label: const Text('Let\'s begin')),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 800),
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
