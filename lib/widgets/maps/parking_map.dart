import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/widgets/maps/zoom_buttons.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:kb4yg/widgets/maps/attribution_card.dart';
import 'package:kb4yg/widgets/maps/cached_tile_provider.dart';
import 'package:kb4yg/widgets/maps/parking_map_popup.dart';
import 'package:kb4yg/widgets/no_internet_widget.dart';

class ParkingMap extends StatefulWidget {
  final LatLng center;
  final List<RecreationArea> locations;
  final void Function(BuildContext, RecreationArea)? onTap;
  final void Function()? scrollUp;
  const ParkingMap(
      {Key? key,
      required this.center,
      required this.locations,
      required this.onTap,
      required this.scrollUp})
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
  bool _hasInternet = true;

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

  // If map fails to load, display internet access error
  void onImageLoadFail() => setState(() => _hasInternet = false);

  @override
  Widget build(BuildContext context) => !_hasInternet
      ? const NoInternetWidget()
      : Stack(
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
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                    showPolygon: false, // Hide triangle on cluster click
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
            ZoomButtons(mapController: mapController),
            // Scroll up button
            if (!kIsWeb)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FloatingActionButton.small(
                      tooltip: 'Scroll up',
                      onPressed: widget.scrollUp,
                      child: const Icon(Icons.keyboard_arrow_up)),
                ),
              )
          ],
        );
}