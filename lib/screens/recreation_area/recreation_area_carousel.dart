import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import '../../widgets/loading_indicator.dart';

class WebRecreationAreaCarousel extends StatelessWidget {
  final List<String> images;
  final String caption;

  const WebRecreationAreaCarousel(
      {Key? key, required this.images, required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight, width: 4))),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 400,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 17),
        ),
        itemCount: images.length,
        itemBuilder: (context, itemIndex, pageViewIndex) => CachedNetworkImage(
          imageUrl: images[itemIndex],
          imageBuilder: (context, imageProvider) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                      image: DecorationImage(
                          opacity: .75,
                          image: imageProvider,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.fitWidth)),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(caption,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          placeholder: (context, url) => const LoadingIndicator(),
          errorWidget: (context, url, error) {
            if (kDebugMode) print(error);
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

class MobileRecreationAreaCarousel extends StatelessWidget {
  final List<String> images;
  final String caption;

  const MobileRecreationAreaCarousel(
      {Key? key, required this.images, required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 17),
          enlargeCenterPage: true,
        ),
        itemCount: images.length,
        itemBuilder: (context, itemIndex, pageViewIndex) => Card(
          margin: const EdgeInsets.symmetric(vertical: 15),
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: CachedNetworkImage(
            memCacheHeight: 444,
            memCacheWidth: 250,
            imageUrl: images[itemIndex],
            imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsets.all(10.0),
              // child: Column(
              //   children: [
              // Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    image: imageProvider,
                  ),
                ),
              ),
              // ),
              //   Padding(
              //       padding: const EdgeInsets.only(top: 10),
              //       child: SelectableText(
              //         caption,
              //         style: Theme.of(context).textTheme.caption,
              //       )),
              // ],
              // ),
            ),
            placeholder: (context, url) => const LoadingIndicator(),
            errorWidget: (context, url, error) {
              if (kDebugMode) print(error);
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}
