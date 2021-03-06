import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:kb4yg/widgets/parking_table.dart';
import 'package:kb4yg/widgets/screen_template.dart';

import '../../widgets/error_card.dart';
import '../../widgets/expanded_section.dart';
import '../../widgets/loading_indicator.dart';
import 'county_map.dart';

class CountyScreen extends StatefulWidget {
  final String countyName;
  final String countyUrl;

  const CountyScreen(this.countyName, this.countyUrl, {Key? key})
      : super(key: key);

  @override
  State<CountyScreen> createState() => _CountyScreenState();
}

class _CountyScreenState extends State<CountyScreen> {
  late Future<County> futureCounty;

  @override
  void initState() {
    super.initState();
    // futureCounty = Future<County>.value(County.fromJson(bentonCountyJson));
    futureCounty = BackendProvider.of(context).getCounty(widget.countyUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      hasScrollbar: false,
      title: TextButton(
        child: Text('${widget.countyName} County',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () {
          Beamer.of(context).beamToNamed(constants.routeLocations);
        },
      ),
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
              return const LoadingIndicator();
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
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _county = widget.county;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            constraints.maxWidth > 1000
                ? Row(children: getContent(context))
                : Column(children: getContent(context)));
  }

  List<Widget> getContent(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    return [
      ExpandedSection(
        expand: !_isFullscreen,
        collapseVertical: !isWideScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isWideScreen)
              SelectableText('${_county.name} County',
                  style: Theme.of(context).textTheme.headline4),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: isWideScreen // Limit height if not widescreen
                        ? double.infinity
                        : MediaQuery.of(context).size.height / 2),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    thickness: 6,
                    child: ParkingTable(
                      locations: _county.recreationAreas,
                      fireDangerColor: _county.fireDanger.color,
                      onRefresh: () async {
                        // TODO: Fix bug where parking map is not updated here
                        final updatedCounty = await BackendProvider.of(context)
                            .getCounty(_county.name);

                        setState(() {
                          _county.recreationAreas =
                              updatedCounty.recreationAreas;
                          _county.parkingLots = updatedCounty.parkingLots;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: kIsWeb
            ? CountyMap(
                county: _county,
                maximizeToggle: () =>
                    setState(() => _isFullscreen = !_isFullscreen),
              )
            : Card(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: CountyMap(
                  county: _county,
                  maximizeToggle: () =>
                      setState(() => _isFullscreen = !_isFullscreen),
                ),
              ),
      )
    ];
  }
}
