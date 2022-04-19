import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/sanitize_url.dart';
import '../../widgets/search_bar.dart';

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
                  padding: const EdgeInsets.all(8),
                  itemCount: _displayedCounties.length,
                  itemBuilder: (context, index) {
                    String county = _displayedCounties[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 20.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: ElevatedButton(
                            onPressed: () => viewCountyDetails(context, county),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  '${county.toUpperCase()} COUNTY',
                                  textScaleFactor: 1.3,
                                ))),
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
