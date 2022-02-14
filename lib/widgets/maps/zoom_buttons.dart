import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ZoomButtons extends StatefulWidget {
  final MapController mapController;
  const ZoomButtons({Key? key, required this.mapController}) : super(key: key);

  @override
  State<ZoomButtons> createState() => _ZoomButtonsState();
}

class _ZoomButtonsState extends State<ZoomButtons>
    with TickerProviderStateMixin {
  // Extend with ticker for vsync of AnimationController
  get mapController => widget.mapController;

  // Animate zooming with buttons -- adapted from:
  // https://github.com/fleaflet/flutter_map/blob/master/example/lib/pages/animated_map_controller.dart
  void animatedMapZoom(double destZoom) {
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    // The animation determines what path the animation will take
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(mapController.center, _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: kIsWeb
              ? const EdgeInsets.only(bottom: 5.0)
              : const EdgeInsets.all(0),
          child: FloatingActionButton.small(
              child: const Icon(Icons.add),
              tooltip: 'Zoom in',
              onPressed: () {
                var zoom = mapController.zoom + 0.75;
                animatedMapZoom(zoom);
              }),
        ),
        FloatingActionButton.small(
            child: const Icon(Icons.remove),
            tooltip: 'Zoom Out',
            onPressed: () {
              var zoom = mapController.zoom - 0.75;
              animatedMapZoom(zoom);
            }),
      ],
    );
  }
}
