import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key, required this.images, required this.carouselText})
      : super(key: key);

  final List<String> carouselText;
  final List<AssetImage> images;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      constraints: const BoxConstraints(maxWidth: 1000),
      child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
          ),
          itemCount: widget.images.length,
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
                                image: widget.images[itemIndex]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          widget.carouselText[itemIndex],
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
    );
    ;
  }
}
