import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<ImageProvider> images;
  final List<String>? captions;
  final BoxConstraints? constraints;

  const Carousel(
      {Key? key, required this.images, this.captions, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: constraints,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 20),
            enlargeCenterPage: true,
          ),
          itemCount: images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) => Card(
            elevation: 10.0,
            shadowColor: Colors.white,
            clipBehavior: Clip.hardEdge,
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
                        image: images[itemIndex],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: captions == null
                        ? null
                        : SelectableText(
                            captions![itemIndex],
                            style: Theme.of(context).textTheme.caption,
                          )),
              ]),
            ),
          ),
        ));
  }
}
