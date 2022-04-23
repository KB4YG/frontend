import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class HomeScreenCarousel extends StatelessWidget {
  const HomeScreenCarousel({Key? key}) : super(key: key);

  static const List<AssetImage> images = [
    AssetImage('assets/images/fitton-green-2.jpg'),
    AssetImage('assets/images/fitton-green-1.jpg'),
    AssetImage('assets/images/fitton-green-3.jpg')
  ];
  static const List<String> captions = [
    'Fitton Green',
    'Fitton Green',
    'Fitton Green'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 20),
          enlargeCenterPage: true,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            kIsWeb
                ? WebHomeScreenCarousel(
                    image: images[itemIndex], caption: captions[itemIndex])
                : MobileHomeScreenCarousel(
                    image: images[itemIndex], caption: captions[itemIndex]));
  }
}

class WebHomeScreenCarousel extends StatelessWidget {
  final ImageProvider image;
  final String caption;

  const WebHomeScreenCarousel(
      {Key? key, required this.image, this.caption = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          image: image)))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SelectableText(caption,
                  style: Theme.of(context).textTheme.caption))
        ]));
  }
}

class MobileHomeScreenCarousel extends StatelessWidget {
  final ImageProvider image;
  final String caption;

  const MobileHomeScreenCarousel(
      {Key? key, required this.image, this.caption = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                              image: image)))),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SelectableText(caption,
                      style: Theme.of(context).textTheme.caption))
            ])));
  }
}
