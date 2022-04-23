import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/screens/county_list/county_list_map.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/loading_indicator.dart';
import 'package:kb4yg/widgets/screen_template.dart';

import '../../models/parking_lot.dart';
import '../../providers/backend.dart';
import '../../widgets/error_card.dart';
import '../../widgets/expanded_section.dart';
import 'county_list.dart';

class CountyListScreen extends StatelessWidget {
  static const path = constants.routeLocations; // Beamer url path pattern
  const CountyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 900) {
        return const DesktopCountyListScreen();
      } else {
        return const MobileCountyListScreen();
      }
    });
  }
}

class DesktopCountyListScreen extends StatefulWidget {
  const DesktopCountyListScreen({Key? key}) : super(key: key);

  @override
  State<DesktopCountyListScreen> createState() =>
      _DesktopCountyListScreenState();
}

class _DesktopCountyListScreenState extends State<DesktopCountyListScreen> {
  late Future<List<String>> _countyList;
  late Future<List<ParkingLot>> _parkingLots;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _parkingLots = BackendProvider.of(context).fetchParkingLots();
    // _countyList = Future<List<String>>.value([
    //   'BAKER', 'BENTON', 'CLACKAMAS', 'CLATSOP', 'COOS', 'DESCHUTES', 'DOUGLAS',
    //   'LANE', 'LINN', 'MARION', 'MULTNOMAH', 'POLK', 'UNION', 'WASCO', 'WASHINGTON',
    // ]);
    _countyList = BackendProvider.of(context).getCountyList();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
        hasScrollbar: false,
        child: Row(
          children: [
            // County list
            ExpandedSection(
              expand: !_isFullscreen,
              collapseVertical: false,
              child: Center(
                child: Column(children: [
                  // County list header
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Search by County',
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  // County list
                  Expanded(
                    child: FutureBuilder<List<String>>(
                        future: _countyList,
                        builder: (context, snapshot) => snapshot.hasData
                            ? CountyList(countyList: snapshot.data!)
                            : snapshot.hasError
                                ? ErrorCard(
                                    title: 'Failed to retrieve county list',
                                    message: snapshot.error.toString())
                                : const LoadingIndicator()),
                  ),
                ]),
              ),
            ),
            // Statewide parking lot map
            Expanded(
              child: FutureBuilder<List<ParkingLot>>(
                  future: _parkingLots,
                  builder: (context, snapshot) => snapshot.hasData
                      ? CountyListMap(
                          parkingLots: snapshot.data!,
                          maximizeToggle: () => setState(() {
                                _isFullscreen = !_isFullscreen;
                              }))
                      : snapshot.hasError
                          ? ErrorCard(
                              title: 'Failed to retrieve list of parking lots',
                              message: snapshot.error.toString())
                          : const LoadingIndicator()),
            )
          ],
        ));
  }
}

class MobileCountyListScreen extends StatefulWidget {
  const MobileCountyListScreen({Key? key}) : super(key: key);

  @override
  State<MobileCountyListScreen> createState() => _MobileCountyListScreenState();
}

class _MobileCountyListScreenState extends State<MobileCountyListScreen> {
  late Future<List<String>> _countyList;
  late Future<List<ParkingLot>> _parkingLots;

  @override
  void initState() {
    super.initState();
    _parkingLots = BackendProvider.of(context).fetchParkingLots();
    // _countyList = Future<List<String>>.value([
    //   'BAKER', 'BENTON', 'CLACKAMAS', 'CLATSOP', 'COOS', 'DESCHUTES', 'DOUGLAS',
    //   'LANE', 'LINN', 'MARION', 'MULTNOMAH', 'POLK', 'UNION', 'WASCO', 'WASHINGTON',
    // ]);
    _countyList = BackendProvider.of(context).getCountyList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: kIsWeb ? 1 : 2,
        child: ScreenTemplate(
            hasScrollbar: false,
            title: const Text('Select Location'),
            bottom: const TabBar(
              tabs: [Tab(text: 'County List'), Tab(text: 'Map')],
            ),
            child: TabBarView(
              children: [
                FutureBuilder<List<String>>(
                    future: _countyList,
                    builder: (context, snapshot) => snapshot.hasData
                        ? CountyList(countyList: snapshot.data!)
                        : snapshot.hasError
                            ? ErrorCard(
                                title: 'Failed to retrieve county list',
                                message: snapshot.error.toString())
                            : const LoadingIndicator()),
                if (!kIsWeb)
                  FutureBuilder<List<ParkingLot>>(
                      future: _parkingLots,
                      builder: (context, snapshot) => snapshot.hasData
                          ? CountyListMap(parkingLots: snapshot.data!)
                          : snapshot.hasError
                              ? ErrorCard(
                                  title: 'Failed to retrieve county list',
                                  message: snapshot.error.toString())
                              : const LoadingIndicator())
              ],
            )));
  }
}
