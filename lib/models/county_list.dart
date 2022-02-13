import 'package:flutter/material.dart' show BuildContext;
import 'package:kb4yg/models/county.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/utilities/sanitize_url.dart';
import 'package:provider/provider.dart' show Provider;


class Counties {
  late final Map<String, County> counties;
  bool hasData = false;

  // Constructor 1:
  //  Counties counties = Counties();
  //  await counties.init();
  Counties();

  // Constructor 2:
  //  Counties counties = await Counties.create()
  static Future<Counties> create() async {
    Counties counties = Counties();
    await counties.init();
    return counties;
  }

  // Initial API call to get all counties and corresponding locations
  Future<void> init() async {
    print("refresh");
    if (!hasData) {
      // TODO: connect API with Counties()
      print('Created New Counties()');
      counties = {
        'benton': County('Benton', locs: [
          // coordinates from https://www.gps-coordinates.net/
          RecreationArea('Fitton Green',
              address: '980 NW Panorama Dr', lat: 44.577511, lng: -123.36783),
          // AccessPoint('Oak Creek Preserve',
          //     lat: 2, lng: 2),
          RecreationArea('Bald Hill',
              address: '6460 NW Oak Creek Dr',
              lat: 44.5687743,
              lng: -123.3335923),
          RecreationArea('McDonald-Dunn Forest',
              address: '2778 NW Sulphur Springs Rd',
              // Many different parking spots
              lat: 44.632795,
              lng: -123.281928),
          RecreationArea('Cardwell Hill',
              address: 'Cardwell Hill Dr, Philomath, OR 97370', // Philomath
              lat: 44.601518,
              lng: -123.423991),
        ]),
        'linn': County('Linn', locs: [
          // coordinates from https://www.gps-coordinates.net/
          RecreationArea('Loc 1',
              address: '980 NW Panorama Dr', lat: 44.577511, lng: -123.36783),
          // AccessPoint('Oak Creek Preserve',
          //     lat: 2, lng: 2),
          RecreationArea('Loc 2',
              address: '6460 NW Oak Creek Dr',
              lat: 44.5687743,
              lng: -123.3335923),
          RecreationArea('Loc 3',
              address: '2778 NW Sulphur Springs Rd',
              // Many different parking spots
              lat: 44.632795,
              lng: -123.281928),
          RecreationArea('Loc 4',
              address: 'Cardwell Hill Dr', // Philomath
              lat: 44.601518,
              lng: -123.423991),
        ]),
      };
      hasData = true;
    }
  }

  // API function
  Future<void> refreshParkingCounts(String county) async {
    // print('API CALL');
    await counties[county]!.refreshParking();
    // return counties[county]!.locs;
  }

  // TODO: replace this inefficient search with data base access
  RecreationArea? getRecArea(String recreationAreaName) {
    for (var county in counties.values) {
      for (var loc in county.locs) {
        if (sanitizeUrl(loc.name) == recreationAreaName) {
          return loc;
        }
      }
    }
    return null;
  }

  // Accessors
  int get length => counties.keys.length;
  List getLocations(String county) => counties[county]!.locs;
  String elementAt(int index) => counties.keys.elementAt(index);

  // Context accessor (final counties = Counties.of(context);
  static Counties of(BuildContext context) =>
      Provider.of<Counties>(context, listen: false);

  // Overridden operators
  operator [](String? key) => key == null ? null : counties[key];
  operator []=(String key, dynamic value) => counties[key] = value; // set

}
