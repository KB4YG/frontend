import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

final List<String> slideData = [
  'header Text 1',
  'header Text 2',
  'header Text 3',
  'header Text 4',
  'header Text 5',
];

class Home extends StatelessWidget {
  final String title;

  static const List<String> urls = ['https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'];

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedCounty = ModalRoute.of(context)?.settings.arguments == null ?
      null : (ModalRoute.of(context)?.settings.arguments as ScreenArguments).county;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(title),
        centerTitle: true,
      ),
      // body: body(_currentIndex, setCurrentIndex),
      endDrawer: const Settings(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 130, 30),
        child: FloatingActionButton.extended(
            hoverColor: Colors.orange,
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                constants.navSelectCounty,
                arguments: ScreenArguments(county: selectedCounty));
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
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
                  // alignment: Alignment.center,
                  // clipBehavior: Clip.hardEdge,
                  // width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    border: Border.all(width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(urls[itemIndex]),
                  ),
                  ),
                )
            ),
        ),
      ),
    );
  }
}