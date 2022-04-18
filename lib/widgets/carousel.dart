import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  Carousel(
      {Key? key,
      required this.urlImageList,
      required this.assetImageList,
      required this.areaNameList,
      required this.areaName})
      : super(key: key);

  final List<String?> urlImageList;
  final List<String?> assetImageList;
  final List<String?> areaNameList;
  final String? areaName;
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List<String?> areaNameList2 = [];
  //make decision based on the the type of image widget is used.
  List<dynamic> loadImages() {
    List<dynamic> loadImages = [];
    if (widget.urlImageList.isNotEmpty) {
      for (var i = 0; i < widget.urlImageList.length; i++) {
        loadImages.add(Image.network(widget.urlImageList[i]!));
        areaNameList2.add(widget.areaName);
      }
    } else {
      for (var i = 0; i < widget.assetImageList.length; i++) {
        loadImages.add(Image(image: AssetImage(widget.assetImageList[i]!)));
        areaNameList2.add(widget.areaNameList[i]);
      }
    }

    return loadImages;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 15 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
          ),
          itemCount: loadImages().length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) => Card(
            elevation: 10.0,
            shadowColor: Colors.white,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        image: loadImages()[itemIndex].image,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    areaNameList2[0]!,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
