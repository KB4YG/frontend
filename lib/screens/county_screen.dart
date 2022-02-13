import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/widgets/fire_safety.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/maps/parking_map.dart';
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/expanded_section.dart';

class CountyScreen extends StatefulWidget {
  final County county;
  const CountyScreen({Key? key, required this.county}) : super(key: key);

  @override
  State<CountyScreen> createState() => _CountyScreenState();
}

class _CountyScreenState extends State<CountyScreen> {
  // final ScrollController _scrollController = ScrollController();
  bool _isFullscreen = false;

  Future _pullRefresh() async {
    // TODO: ensure responsive UX
    //await Future.delayed(Duration(seconds: 2));
    await widget.county.refreshParking();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: TextButton.icon(
        icon: const Icon(Icons.edit_location),
        label: Text('${widget.county.name} County',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () {
          Beamer.of(context).beamToNamed(constants.routeLocations,
              data: ScreenArguments(county: widget.county));
        },
      )),
      endDrawer: const Settings(),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                kToolbarHeight -
                kBottomNavigationBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpandedSection(
                  expand: !_isFullscreen,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Center(child: ParkingTable(county: widget.county)),
                      // FireSafety(county: widget.county),
                    ],
                    // ),
                  ),
                ),
                Expanded(
                  child: ParkingMap(
                    center: LatLng(44.5646, -123.2620), // Corvallis
                    locations: widget.county.locs,
                    onTap: (BuildContext context, RecreationArea loc) {
                      String route = constants.routeLocations;
                      route +=
                          sanitizeUrl('/${widget.county.name}/${loc.name}');
                      Beamer.of(context).beamToNamed(route);
                    },
                    maximizeToggle: () => setState(() {
                      _isFullscreen = !_isFullscreen;
                    }),
                    // scrollUp: () =>
                    //   _scrollController.animateTo(
                    //       _scrollController.position.minScrollExtent,
                    //       duration: const Duration(milliseconds: 400),
                    //       curve: Curves.fastOutSlowIn),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
