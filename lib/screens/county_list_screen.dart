import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/backend.dart';
import '../widgets/error_card.dart';
import '../widgets/search_bar.dart';

class CountyListScreen extends StatefulWidget {
  static const path = constants.routeLocations; // Beamer url path pattern
  const CountyListScreen({Key? key}) : super(key: key);

  @override
  State<CountyListScreen> createState() => _CountyListScreenState();
}

class _CountyListScreenState extends State<CountyListScreen> {
  late Future<List<String>> _futureCountyList;

  @override
  void initState() {
    super.initState();
    // _futureCountyList = Future<List<String>>.value([
    //   'BAKER', 'BENTON', 'CLACKAMAS', 'CLATSOP', 'COOS', 'DESCHUTES',
    //   'DOUGLAS', 'LANE', 'LINN', 'MARION', 'MULTNOMAH', 'POLK', 'UNION',
    //   'WASCO', 'WASHINGTON',
    // ]);
    _futureCountyList = BackendProvider.of(context).getCountyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const Settings(),
        appBar: const Header(title: Text('Select a County')),
        body: Center(
          child: FutureBuilder<List<String>>(
              future: _futureCountyList,
              builder: (context, snapshot) => snapshot.hasData
                  ? CountyList(countyList: snapshot.data!)
                  : snapshot.hasError
                      ? ErrorCard(
                          title: 'Failed to retrieve county list',
                          message: snapshot.error.toString())
                      : const CircularProgressIndicator()),
        ));
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

  void viewCountyDetails(BuildContext context, String county) async {
    // Store selected county in user's local storage
    final prefs = Provider.of<SharedPreferences>(context, listen: false);
    prefs.setString(constants.prefCounty, county);

    final path = sanitizeUrl('${constants.routeLocations}/$county');
    context.beamToNamed(path);
  }

  void filterSearchResults(String query) async {
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
                onChanged: (value) => filterSearchResults(value)),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: _displayedCounties.length,
                  itemBuilder: (context, index) {
                    String county = _displayedCounties[index];
                    return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () => viewCountyDetails(context, county),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${county.toUpperCase()} COUNTY',
                                  textScaleFactor: 1.3,
                                ))));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
