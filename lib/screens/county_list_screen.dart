import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/extensions/string_extension.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../providers/backend.dart';
import '../widgets/error_card.dart';

class CountyListScreen extends StatefulWidget {
  static const path = constants.routeLocations;
  const CountyListScreen({Key? key}) : super(key: key);

  @override
  State<CountyListScreen> createState() => _CountyListScreenState();
}

class _CountyListScreenState extends State<CountyListScreen> {
  late Future<List<String>> futureCountyList;

  @override
  void initState() {
    super.initState();
    futureCountyList = BackendProvider.of(context).getCountyList();
  }

  void viewCounty(BuildContext context, String county) async {
    // Store selected county in user's local storage
    final prefs = Provider.of<SharedPreferences>(context, listen: false);
    prefs.setString(constants.prefCounty, county);

    context.beamToNamed('${constants.routeLocations}/${county.capitalize()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const Settings(),
        appBar: const Header(title: Text('Select a County')),
        body: Center(
            child: FutureBuilder<List<String>>(
                future: futureCountyList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final String county = snapshot.data![index];
                            return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed: () => viewCounty(context, county),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${county.toUpperCase()} COUNTY',
                                          textScaleFactor: 1.3,
                                        ))));
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorCard(
                      title: 'Failed to retrieve county list',
                      message: snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                })));
  }
}
