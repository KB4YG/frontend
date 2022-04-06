import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/widgets/screen_template.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/parking_lot.dart';
import '../providers/backend.dart';
import '../widgets/error_card.dart';
import '../widgets/expanded_section.dart';
import '../widgets/maps/parking_map.dart';
import '../widgets/search_bar.dart';

class CountyListScreen extends StatelessWidget {
  static const path = constants.routeLocations; // Beamer url path pattern
  const CountyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1000) {
        return const WebCountyListScreen();
      } else {
        return const MobileCountyListScreen();
      }
    });
  }
}

class WebCountyListScreen extends StatefulWidget {
  const WebCountyListScreen({Key? key}) : super(key: key);

  @override
  State<WebCountyListScreen> createState() => _WebCountyListScreenState();
}

class _WebCountyListScreenState extends State<WebCountyListScreen> {
  late Future<List<String>> _futureCountyList;
  late Future<List<ParkingLot>> _parkingLots;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _parkingLots = BackendProvider.of(context).fetchParkingLots();
    // _futureCountyList = Future<List<String>>.value([
    //   'BAKER', 'BENTON', 'CLACKAMAS', 'CLATSOP', 'COOS', 'DESCHUTES',
    //   'DOUGLAS', 'LANE', 'LINN', 'MARION', 'MULTNOMAH', 'POLK', 'UNION',
    //   'WASCO', 'WASHINGTON',
    // ]);
    _futureCountyList = BackendProvider.of(context).getCountyList();
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    return ScreenTemplate(
        hasScrollbar: false,
        child: Row(
          children: [
            ExpandedSection(
              expand: !_isFullscreen,
              collapseVertical: !isWideScreen,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: isWideScreen // Limit height if not widescreen
                          ? double.infinity
                          : MediaQuery.of(context).size.height / 2),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 45,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Search by county',
                              style: Theme.of(context).textTheme.headline4),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<String>>(
                          future: _futureCountyList,
                          builder: (context, snapshot) => snapshot.hasData
                              ? CountyList(countyList: snapshot.data!)
                              : snapshot.hasError
                                  ? ErrorCard(
                                      title: 'Failed to retrieve county list',
                                      message: snapshot.error.toString())
                                  : const Center(
                                      child: CircularProgressIndicator())),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map_outlined,
                        size: 45,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Explore by map',
                            style: Theme.of(context).textTheme.headline4),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder<List<ParkingLot>>(
                        future: _parkingLots,
                        builder: (context, snapshot) => snapshot.hasData
                            ? ParkingLotMap(
                                parkingLots: snapshot.data!,
                                maximizeToggle: () => setState(() {
                                      _isFullscreen = !_isFullscreen;
                                    }))
                            : snapshot.hasError
                                ? ErrorCard(
                                    title:
                                        'Failed to retrieve list of parking lots',
                                    message: snapshot.error.toString())
                                : const Center(
                                    child: CircularProgressIndicator())),
                  ),
                ],
              ),
            )
          ],
        )
        //   } else {
        //   }
        // },
        // ),
        // ],
        // ),
        );
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
    // _futureCountyList = Future<List<String>>.value([
    //   'BAKER', 'BENTON', 'CLACKAMAS', 'CLATSOP', 'COOS', 'DESCHUTES',
    //   'DOUGLAS', 'LANE', 'LINN', 'MARION', 'MULTNOMAH', 'POLK', 'UNION',
    //   'WASCO', 'WASHINGTON',
    // ]);
    _countyList = BackendProvider.of(context).getCountyList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: ScreenTemplate(
            hasScrollbar: false,
            title: const Text('Select Location'),
            bottom: const TabBar(
              tabs: [Tab(text: 'County List'), Tab(text: 'Explore')],
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
                            : const Center(child: CircularProgressIndicator())),
                FutureBuilder<List<ParkingLot>>(
                    future: _parkingLots,
                    builder: (context, snapshot) => snapshot.hasData
                        ? ParkingLotMap(parkingLots: snapshot.data!)
                        : snapshot.hasError
                            ? ErrorCard(
                                title: 'Failed to retrieve county list',
                                message: snapshot.error.toString())
                            : const Center(child: CircularProgressIndicator()))
              ],
            )));
  }
}

class ParkingLotMap extends StatelessWidget {
  final List<ParkingLot> parkingLots;
  final Function()? maximizeToggle;
  const ParkingLotMap(
      {Key? key, required this.parkingLots, this.maximizeToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: ParkingMap(
          zoom: kIsWeb ? 7.0 : 6.0,
          center: LatLng(43.8041, -120.5542),
          locations: parkingLots,
          onTap: (BuildContext context, ParkingLot loc) {
            // String route = sanitizeUrl(
            //     '${constants.routeLocations}/${loc.county}/${loc.recreationArea}');
            // Beamer.of(context).beamToNamed(route);
          },
          maximizeToggle: maximizeToggle),
    );
  }
}

class CountyList extends StatefulWidget {
  final List<String> countyList;
  const CountyList({Key? key, required this.countyList}) : super(key: key);

  @override
  _CountyListState createState() => _CountyListState();
}

class _CountyListState extends State<CountyList> {
  final TextEditingController _editingController = TextEditingController();
  final List<String> _displayedCounties = [];

  @override
  void initState() {
    super.initState();
    _displayedCounties.addAll(widget.countyList);
  }

  void viewCountyDetails(BuildContext context, String county) {
    // Store selected county in user's local storage
    final prefs = Provider.of<SharedPreferences>(context, listen: false);
    prefs.setString(constants.prefCounty, county);

    final path = sanitizeUrl('${constants.routeLocations}/$county');
    context.beamToNamed(path);
  }

  void filterSearchResults(String query) {
    _displayedCounties.clear();
    if (query.isNotEmpty) {
      List<String> matches = [];
      for (var countyName in widget.countyList) {
        if (countyName.toLowerCase().contains(query.toLowerCase())) {
          matches.add(countyName);
        }
      }
      setState(() => _displayedCounties.addAll(matches));
    } else {
      setState(() => _displayedCounties.addAll(widget.countyList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
      child: Column(
        children: [
          // Display search bar if more than three counties
          if (widget.countyList.length > 3)
            SearchBar(
                editingController: _editingController,
                onChanged: (value) => filterSearchResults(value),
                hintText: 'Search counties'),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: _displayedCounties.length,
                  itemBuilder: (context, index) {
                    String county = _displayedCounties[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Card(
                        elevation: 3.0,
                        color: Colors.grey[200],
                        margin: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          TextButton(
                            onPressed: () => viewCountyDetails(context, county),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                '${county.toUpperCase()} COUNTY',
                                textScaleFactor: 1.2,
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
