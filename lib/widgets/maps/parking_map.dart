import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:kb4yg/models/parking_lot.dart';
import 'package:kb4yg/widgets/maps/zoom_buttons.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:kb4yg/widgets/maps/attribution_card.dart';
import 'package:kb4yg/widgets/maps/cached_tile_provider.dart';
import 'package:kb4yg/widgets/maps/parking_map_popup.dart';
import 'package:kb4yg/widgets/maps/fullscreen_button.dart';

class ParkingMap extends StatefulWidget {
  final LatLng center;
  final List<ParkingLot> locations;
  final void Function(BuildContext, ParkingLot)? onTap;
  // final void Function()? scrollUp;
  final void Function()? maximizeToggle;
  const ParkingMap(
      {Key? key,
      required this.center,
      required this.locations,
      this.onTap,
      // this.scrollUp,
      this.maximizeToggle})
      : super(key: key);

  @override
  State<ParkingMap> createState() => _ParkingMapState();
}

class _ParkingMapState extends State<ParkingMap> {
  late final List<Marker> markers;
  // Prevent user from scrolling outside state (update if expand beyond Oregon)
  final panBoundaryNE = LatLng(45.0, -118.0);
  final panBoundarySW = LatLng(43.0, -124.0);
  // Popup controller: used to trigger popup display/hiding
  final PopupController popupController = PopupController();
  // Map controller: handle zoom button actions
  final MapController mapController = MapController();
  bool _displaySnackBar = true;

  @override
  void initState() {
    super.initState();
    markers = [
      for (var loc in widget.locations)
        Marker(
            anchorPos: AnchorPos.align(AnchorAlign.top),
            height: 40,
            width: 40,
            point: LatLng(loc.lat, loc.lng),
            builder: (context) => MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Tooltip(
                    message: loc.name,
                    child: const Icon(
                      Icons.pin_drop,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                  ),
                ))
    ];
  }

  void suppressSnackBar(Duration duration) async {
    if (_displaySnackBar) {
      _displaySnackBar = false;
      await Future.delayed(duration);
      _displaySnackBar = true;
    }
  }

  // If map fails to load, display internet access snack bar error
  void onImageLoadFail() {
    if (_displaySnackBar) {
      final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          content: const Text('Failed to retrieve map images. \n'
              'Please check your internet connection.'),
          action: SnackBarAction(
            label: 'DISMISS',
            onPressed: () {
              suppressSnackBar(const Duration(seconds: 30));
              ScaffoldMessenger.of(context).clearSnackBars();
            },
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      suppressSnackBar(const Duration(seconds: 10)); // Reduce # messages
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            plugins: [MarkerClusterPlugin()],
            center: widget.center,
            zoom: 10.0,
            minZoom: 7.0,
            maxZoom: 15.0,
            // allowPanningOnScrollingParent: false,
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            nePanBoundary: panBoundaryNE,
            swPanBoundary: panBoundarySW,
            // Hide popup when the map is tapped.
            onTap: (_, __) => popupController.hideAllPopups(),
          ),
          children: [
            TileLayerWidget(
                options: TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              tileProvider: CachedTileProvider(onError: onImageLoadFail),
              attributionBuilder: (_) => const AttributionCard(),
            )),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                animationsOptions: const AnimationsOptions(
                    fitBound: Duration(milliseconds: 1000)),
                maxClusterRadius: 40,
                size: const Size(40, 40),
                showPolygon: false,
                // Hide triangle on cluster click
                markers: markers,
                // anchor: AnchorPos.align(AnchorAlign.left),
                builder: (context, markers) {
                  return FloatingActionButton(
                    mouseCursor: SystemMouseCursors.click,
                    // backgroundColor: Colors.green, // Specify color of cluster
                    child: Text(markers.length.toString()),
                    onPressed: null,
                  );
                },
                fitBoundsOptions: const FitBoundsOptions(
                  maxZoom: 12.0, // Changes zoom of cluster click
                  padding: EdgeInsets.all(50),
                ),
                popupOptions: PopupOptions(
                    popupController: popupController,
                    popupBuilder: (context, Marker marker) {
                      // Get parking lot corresponding to marker index
                      var index = markers.indexOf(marker);
                      var loc = widget.locations[index];
                      return ParkingMapPopup(
                        marker: marker,
                        location: loc,
                        onTap: () => widget.onTap == null
                            ? null
                            : widget.onTap!(context, loc),
                      );
                    }),
              ),
            )
          ],
        ),
        // Map Buttons
        if (widget.maximizeToggle != null)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FullscreenButton(maximizeToggle: widget.maximizeToggle),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 60, 8, 40),
          child: Align(
            alignment: kIsWeb ? Alignment.topLeft : Alignment.bottomRight,
            child: ZoomButtons(mapController: mapController),
          ),
        )
      ],
    );
  }
}
