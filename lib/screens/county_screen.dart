import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/maps/parking_map.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:latlong2/latlong.dart';

import '../benton_county.dart';
import '../models/parking_lot.dart';
import '../widgets/error_card.dart';
import '../widgets/expanded_section.dart';

class CountyScreen extends StatefulWidget {
  final String countyName;
  const CountyScreen(this.countyName, {Key? key}) : super(key: key);

  @override
  State<CountyScreen> createState() => _CountyScreenState();
}

class _CountyScreenState extends State<CountyScreen> {
  late Future<County> futureCounty;

  @override
  void initState() {
    super.initState();
    _fetchCounty(context);
  }

  Future<void> _fetchCounty(BuildContext context) async {
    // futureCounty = Future<County>.value(County.fromJson(bentonCountyJson));
    futureCounty = BackendProvider.of(context).getCounty(widget.countyName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: TextButton(
          child: Text('${widget.countyName} County',
          style: const TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            Beamer.of(context).beamToNamed(constants.routeLocations);
          },
        )
      ),
      endDrawer: const Settings(),
      body: FutureBuilder<County>(
          future: futureCounty,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CountyScreenContent(county: snapshot.data!);
            } else if (snapshot.hasError) {
              return ErrorCard(
                  title: 'Failed to retrieve county information',
                  message: snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class CountyScreenContent extends StatefulWidget {
  final County county;
  const CountyScreenContent({Key? key, required this.county}) : super(key: key);

  @override
  _CountyScreenContentState createState() => _CountyScreenContentState();
}

class _CountyScreenContentState extends State<CountyScreenContent> {
  late final County _county;
  late List<ParkingLot> _parkingLots;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _county = widget.county;
    _parkingLots = _county.parkingLots;
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            constraints.maxWidth > 1000
                ? Row(children: getContent(context))
                : Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                        ExpandedSection(
                          expand: !_isFullscreen,
                          collapseVertical: !isWideScreen,
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      isWideScreen // Limit height if not widescreen
                                          ? double.infinity
                                          : MediaQuery.of(context).size.height /
                                              2),
                              child: Scrollbar(
                                isAlwaysShown: true,
                                thickness: 6,
                                child: ParkingTable(
                                    county: _county,
                                    onRefresh: () async {
                                      final updatedCounty =
                                          await BackendProvider.of(context)
                                              .getCounty(_county.name);

                                      setState(() {
                                        _county.recreationAreas =
                                            updatedCounty.recreationAreas;
                                        _county.parkingLots =
                                            updatedCounty.parkingLots;
                                        _parkingLots = _county.parkingLots;
                                      });
                                      print(_parkingLots);
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 300),
                            child: ParkingMap(
                              center: LatLng(_county.lat, _county.lng),
                              locations: _parkingLots,
                              onTap: (BuildContext context, ParkingLot loc) {
                                String path = sanitizeUrl(
                                    '${constants.routeLocations}/${_county.name}/${loc.recreationArea}');
                                Beamer.of(context).beamToNamed(path);
                              },
                              maximizeToggle: () => setState(() {
                                _isFullscreen = !_isFullscreen;
                              }),
                            ),
                          ),
                        )
                      ]));
  }

  List<Widget> getContent(context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    return [
      ExpandedSection(
        expand: !_isFullscreen,
        collapseVertical: !isWideScreen,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: isWideScreen // Limit height if not widescreen
                    ? double.infinity
                    : MediaQuery.of(context).size.height / 2),
            child: ParkingTable(
                county: _county,
                onRefresh: () async {
                  // TODO: Fix bug where parking map is not updated here
                  final updatedCounty =
                      await BackendProvider.of(context).getCounty(_county.name);

                  setState(() {
                    _county.recreationAreas = updatedCounty.recreationAreas;
                    _county.parkingLots = updatedCounty.parkingLots;
                    _parkingLots = _county.parkingLots;
                  });
                  print(_parkingLots);
                }),
          ),
        ),
      ),
      Expanded(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300),
          child: ParkingMap(
            center: LatLng(_county.lat, _county.lng),
            locations: _parkingLots,
            onTap: (BuildContext context, ParkingLot loc) {
              String route = sanitizeUrl(
                  '${constants.routeLocations}/${_county.name}/${loc.name}');
              Beamer.of(context).beamToNamed(route);
            },
            maximizeToggle: () => setState(() {
              _isFullscreen = !_isFullscreen;
            }),
          ),
        ),
      )
    ];
  }
}
