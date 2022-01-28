import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kb4yg/models/access_point.dart';
import 'package:kb4yg/models/county.dart';
import 'package:latlong2/latlong.dart' show Distance, LatLng;

enum Danger {low, moderate, high}

class _FireDangerLevel {
  static const distance = Distance(); // Class for calculating distance
  final Map<String, int> nearestFires = {}; // Populated in parseData()
  late final Danger danger;   // County danger level enum {low, medium, high}
  late final String message;  // Description of action user should take
  late final Icon icon;       // Colored icon of danger level
  late String info;           // Number of fires in county and nearby
  int numFiresNearby = 0;

  _FireDangerLevel(final Map<String, dynamic> data, final County county) {
    late final Danger danger;
    try {
      // Parse data for highest threat level and nearest fires for each rec area
       danger = parseData(data, county);
    } on TypeError {
      throw ErrorDescription('An error occurred while retrieving wild fire information.');
    }

    // Populate info, message, and icon member variables based on highest threat
    switch (danger) {
      case Danger.high:
        info = 'High';
        message = 'There is at least one fire within likely spreading distance. '
            'Recreation at the following locations is not recommended.';
        icon = const Icon(Icons.warning, color: Colors.red, size: 60);
        break;
      case Danger.moderate:
        info = 'Moderate';
        message = 'There is at least one fire within 10 miles of a recreation '
            'area. Likelihood of spreading is low. Remain cautious.';
        icon = const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 60);
        break;
      default:
        info = 'Low';
        message = 'There are no known fires nearby that are within likely '
            'spreading distance.';
        icon = const Icon(Icons.check_circle_outline, color: Colors.green, size: 60);
    }

    // switch (numFiresNearby) {
    //   case 1:
    //     info += ' (1 fire nearby)';
    //     break;
    //   default:
    //     info += ' ($numFiresNearby fires nearby)';
    // }
  }

  // Validate data from arcgis to ensure it contains needed fields
  bool isValidData(data) {
    return true;
  }

  Danger parseData(Map<String, dynamic> dataFull, final County county) {
    Danger highestThreat = Danger.low;

    for (final Map<String, dynamic> data in dataFull['features']) {
      Danger danger = Danger.low;

      final bool isOut = data['attributes']['FireOutDateTime'] != null;
      final bool isControlled = data['attributes']['ControlDateTime'] != null;

      // If not explicitly out && not explicitly controlled...
      if (!isOut && !isControlled) {
        // Check if explicitly contained
        final bool isContained = data['attributes']['ContainmentDateTime'] != null;

        // Get distance from fire to each recreation area
        final double x1 = data['geometry']['x'];
        final double y1 = data['geometry']['y'];
        for (final AccessPoint loc in county.locs) {
          // Convert meters to miles and round to nearest mile
          final int miles = (distance(LatLng(y1, x1), LatLng(loc.lat, loc.lng)) * 0.00062137).round();

          // If within [0-5] miles: high
          if (miles <= 5) {
            danger = Danger.high;
          }
          // Else If within (5-10] && not explicitly contained: moderate
          else if (miles <= 10 && !isContained) {
            danger = Danger.moderate;
          }

          // Get nearest (min) fire distance for each location
          if (danger != Danger.low) {
            try {
              nearestFires[loc.name] = nearestFires[loc.name]! > miles ? miles : nearestFires[loc.name]!;
            } on Error {
              nearestFires[loc.name] = miles;
            }
            numFiresNearby++;
          }
        }
        highestThreat = danger.index > highestThreat.index ? danger : highestThreat;
      }
    }
    return highestThreat;
  }

}

class FireSafety extends StatelessWidget {
  final County county;
  // TODO: remove unused fields (or use them)
  static const url = "https://services3.arcgis.com/T4QMspbfLg3qTGWY/arcgis/rest/services/Current_WildlandFire_Locations/FeatureServer/0/query?where=POOState%20%3D%20'US-OR'&outFields=POOState,POOCounty,FireMgmtComplexity,FireOutDateTime,ModifiedOnDateTime_dt,CreatedOnDateTime_dt,ContainmentDateTime,ControlDateTime&outSR=4326&f=json";
  const FireSafety({Key? key, required this.county}) : super(key: key);

  Future<_FireDangerLevel> getData() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    // throw Future.error("some error");
    // TODO: add error checking
    // TODO: cache info to our database or at least at user level (reduce API use)
    // final response = await get(Uri.parse(url));
    // final data = jsonDecode(response.body);

    // TEST DATA TODO: remove tests once fire API info is cached
    // Error
    // final Map <String, dynamic> data = {};

    // Low danger, 0 fires nearby
    // final Map <String, dynamic> data = {"objectIdFieldName":"OBJECTID","uniqueIdField":{"name":"OBJECTID","isSystemMaintained":true},"globalIdFieldName":"GlobalID","geometryType":"esriGeometryPoint","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"POOState","type":"esriFieldTypeString","alias":"POO State","sqlType":"sqlTypeOther","length":6,"domain":null,"defaultValue":null},{"name":"POOCounty","type":"esriFieldTypeString","alias":"POO County","sqlType":"sqlTypeOther","length":100,"domain":null,"defaultValue":null},{"name":"FireMgmtComplexity","type":"esriFieldTypeString","alias":"Fire Mgmt Complexity","sqlType":"sqlTypeOther","length":25,"domain":null,"defaultValue":null},{"name":"FireOutDateTime","type":"esriFieldTypeDate","alias":"Fire Out Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ModifiedOnDateTime_dt","type":"esriFieldTypeDate","alias":"Modified On Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"CreatedOnDateTime_dt","type":"esriFieldTypeDate","alias":"Created On Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ContainmentDateTime","type":"esriFieldTypeDate","alias":"Containment Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ControlDateTime","type":"esriFieldTypeDate","alias":"Control Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"}],"features":[{"attributes":{"POOState":"US-OR","POOCounty":"Douglas","FireMgmtComplexity":null,"FireOutDateTime":null,"ModifiedOnDateTime_dt":1642006868000,"CreatedOnDateTime_dt":1621283634343,"ContainmentDateTime":null,"ControlDateTime":null},"geometry":{"x":-122.9040140285088,"y":42.948805284794119}},{"attributes":{"POOState":"US-OR","POOCounty":"Deschutes","FireMgmtComplexity":null,"FireOutDateTime":null,"ModifiedOnDateTime_dt":1642101235267,"CreatedOnDateTime_dt":1642100979657,"ContainmentDateTime":null,"ControlDateTime":null},"geometry":{"x":-121.52851397615072,"y":43.854215474768615}}]};

    // Low danger, 1 controlled nearby WIP
    // final Map <String, dynamic> data = {"objectIdFieldName":"OBJECTID","uniqueIdField":{"name":"OBJECTID","isSystemMaintained":true},"globalIdFieldName":"GlobalID","geometryType":"esriGeometryPoint","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"POOState","type":"esriFieldTypeString","alias":"POO State","sqlType":"sqlTypeOther","length":6,"domain":null,"defaultValue":null},{"name":"POOCounty","type":"esriFieldTypeString","alias":"POO County","sqlType":"sqlTypeOther","length":100,"domain":null,"defaultValue":null},{"name":"FireMgmtComplexity","type":"esriFieldTypeString","alias":"Fire Mgmt Complexity","sqlType":"sqlTypeOther","length":25,"domain":null,"defaultValue":null},{"name":"FireOutDateTime","type":"esriFieldTypeDate","alias":"Fire Out Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ModifiedOnDateTime_dt","type":"esriFieldTypeDate","alias":"Modified On Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"CreatedOnDateTime_dt","type":"esriFieldTypeDate","alias":"Created On Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ContainmentDateTime","type":"esriFieldTypeDate","alias":"Containment Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"},{"name":"ControlDateTime","type":"esriFieldTypeDate","alias":"Control Date Time","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":"-2209161600000"}],"features":[{"attributes":{"POOState":"US-OR","POOCounty":"Douglas","FireMgmtComplexity":null,"FireOutDateTime":null,"ModifiedOnDateTime_dt":1642006868000,"CreatedOnDateTime_dt":1621283634343,"ContainmentDateTime":null,"ControlDateTime":null},"geometry":{"x":-122.9040140285088,"y":42.948805284794119}},{"attributes":{"POOState":"US-OR","POOCounty":"Deschutes","FireMgmtComplexity":null,"FireOutDateTime":null,"ModifiedOnDateTime_dt":1642101235267,"CreatedOnDateTime_dt":1642100979657,"ContainmentDateTime":null,"ControlDateTime":null},"geometry":{"x":-121.52851397615072,"y":43.854215474768615}}]};

    // High danger
    // final Map <String, dynamic> data = {"objectIdFieldName":"OBJECTID","uniqueIdField":{"name":"OBJECTID","isSystemMaintained":true},"globalIdFieldName":"GlobalID","geometryType":"esriGeometryPoint","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"POOState","type":"esriFieldTypeString","alias":"POO State","sqlType":"sqlTypeOther","length":6,"domain":null,"defaultValue":null},{"name":"POOCounty","type":"esriFieldTypeString","alias":"POO County","sqlType":"sqlTypeOther","length":100,"domain":null,"defaultValue":null}],"features":[{"attributes":{"POOState":"US-OR","POOCounty":"Douglas"},"geometry":{"x":-123.36783,"y":44.577511}}]};

    // Moderate danger
    final Map <String, dynamic> data = {"objectIdFieldName":"OBJECTID","uniqueIdField":{"name":"OBJECTID","isSystemMaintained":true},"globalIdFieldName":"GlobalID","geometryType":"esriGeometryPoint","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"POOState","type":"esriFieldTypeString","alias":"POO State","sqlType":"sqlTypeOther","length":6,"domain":null,"defaultValue":null},{"name":"POOCounty","type":"esriFieldTypeString","alias":"POO County","sqlType":"sqlTypeOther","length":100,"domain":null,"defaultValue":null}],"features":[{"attributes":{"POOState":"US-OR","POOCounty":"Douglas"},"geometry":{"x":-123.36783,"y":44.7}}]};

    return _FireDangerLevel(data, county);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_FireDangerLevel>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<_FireDangerLevel> snapshot) {
        Icon? icon;
        Widget tileContent;
        String title = 'Fire Danger Level';
        if (snapshot.hasData) {
          // Success
          final fireDanger = snapshot.data as _FireDangerLevel;
          title += ' - ${fireDanger.info}';
          icon = fireDanger.icon;
          tileContent = Column(
            children: [
              // TODO: make fire data table less ugly
              SelectableText(fireDanger.message, textScaleFactor: 1.2),
              if (fireDanger.nearestFires.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Nearest Fire'))
                    ], rows: [
                      for (var loc in fireDanger.nearestFires.entries)
                        DataRow(cells: [
                          DataCell(SelectableText(loc.key)),
                          DataCell(SelectableText('${loc.value} miles'))
                        ])
                    ],
                  ),
                ),
            ],
          );
        } else if (snapshot.hasError) {
          // Error
          icon = const Icon(Icons.error_outline, color: Colors.red, size: 60);
          tileContent = SelectableText('Error: ${snapshot.error}');
        } else {
          // Loading
          tileContent = const Center(
            child: SizedBox(
              width: 40, height: 40,
              child: CircularProgressIndicator()
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              constraints: const BoxConstraints(maxWidth: 800),
              child: Card(
                child: ListTile (
                  // TODO: align icon vertically
                  // TODO: add info button w/ rating method, data source, & external link for more info
                  // TODO: add accuracy disclaimer
                  // inaccuracies:
                  //    - some fires might not be in dataset
                  //    - entries in dataset may be unupdated (old or more dangerous fires)
                  //    - doesn't look at terrain, spread rate, or anything important (only distance)
                  // links to add:
                  //    - alerts: oralert.gov
                  //    - wildfires.oregon.gov/pages/current-conditions.aspx
                  contentPadding: const EdgeInsets.all(8.0),
                  visualDensity: VisualDensity.comfortable,
                  leading: icon,
                  title: SelectableText(title, textScaleFactor: 1.2,),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: tileContent,
                  ),
                )
              )
            )
          ]
        );
      },
    );
  }
}

// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:fwfh_webview/fwfh_webview.dart';
//   },
// ),
// child: ListView(
//   children: [
// HtmlWidget(
//   '''
//   <iframe
//     width="300"
//     height="200"
//     title="Air quality index widget" src="$url"
//     style="border: none; border-radius: 25px;"
//   ></iframe>
//   ''',
//   factoryBuilder: () => MyWidgetFactory(),
//   // customStylesBuilder: () => style,
// ),
// HtmlWidget(
//   '<iframe width="300" height="200" src="${FireSafety.url}${widget.county}%20County%2C%20${FireSafety.state}"></iframe>',
//   factoryBuilder: () => MyWidgetFactory(),
// ),
//         ]
//         ),
//       ),
//     );
//   }
// }

// class MyWidgetFactory extends WidgetFactory with WebViewFactory {
//   @override
//   String? get webViewUserAgent => 'KB4YG';
// }
