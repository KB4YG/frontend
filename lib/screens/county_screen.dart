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

  Future<void> _fetchCounty(BuildContext context) async =>
      futureCounty = BackendProvider.of(context).getCounty(widget.countyName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          title: TextButton.icon(
        icon: const Icon(Icons.edit_location),
        label: Text('${widget.countyName} County',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () {
          Beamer.of(context).beamToNamed(constants.routeLocations);
        },
      )),
      endDrawer: const Settings(),
      body: RefreshIndicator(
        onRefresh: () => _fetchCounty(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                kToolbarHeight -
                kBottomNavigationBarHeight,
            child: FutureBuilder<County>(
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
          ),
        ),
      ),
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
  get county => widget.county;
  bool _isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpandedSection(
          expand: !_isFullscreen,
          child: Center(child: ParkingTable(county: widget.county)),
        ),
        Expanded(
          child: ParkingMap(
            center: LatLng(widget.county.lat, widget.county.lng), // Corvallis
            locations: widget.county.parkingLots,
            onTap: (BuildContext context, ParkingLot loc) {
              String route = constants.routeLocations;
              route += sanitizeUrl('/${widget.county.name}/${loc.name}');
              Beamer.of(context).beamToNamed(route);
            },
            maximizeToggle: () => setState(() {
              _isFullscreen = !_isFullscreen;
            }),
          ),
        ),
      ],
    );
  }
}
