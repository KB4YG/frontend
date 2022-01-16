import 'package:kb4yg/county.dart';
import 'package:kb4yg/access_point.dart';

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

  // API Call to get all counties and corresponding locations
  Future<void> init() async {
    if (!hasData) {
      // TODO: connect API with Counties()
      print('Created New Counties()');
      counties = {
        'Benton': County('Benton', locs: [
          // coordinates from https://www.gps-coordinates.net/
          AccessPoint('Fitton Green',
              address: '980 NW Panorama Dr', lat: 44.577511, lng: -123.36783),
          // AccessPoint('Oak Creek Preserve',
          //     lat: 2, lng: 2),
          AccessPoint('Bald Hill',
              address: '6460 NW Oak Creek Dr',
              lat: 44.5687743,
              lng: -123.3335923),
          AccessPoint('McDonald-Dunn Forest',
              address: '2778 NW Sulphur Springs Rd',
              // Many different parking spots
              lat: 44.632795,
              lng: -123.281928),
          AccessPoint('Cardwell Hill',
              address: 'Cardwell Hill Dr', // Philomath
              lat: 44.601518,
              lng: -123.423991),
        ]),
        'Linn': County('Linn', locs: [
          // coordinates from https://www.gps-coordinates.net/
          AccessPoint('Loc 1',
              address: '980 NW Panorama Dr', lat: 44.577511, lng: -123.36783),
          // AccessPoint('Oak Creek Preserve',
          //     lat: 2, lng: 2),
          AccessPoint('Loc 2',
              address: '6460 NW Oak Creek Dr',
              lat: 44.5687743,
              lng: -123.3335923),
          AccessPoint('Loc 3',
              address: '2778 NW Sulphur Springs Rd',
              // Many different parking spots
              lat: 44.632795,
              lng: -123.281928),
          AccessPoint('Loc 4',
              address: 'Cardwell Hill Dr', // Philomath
              lat: 44.601518,
              lng: -123.423991),
        ]),
      };
      hasData = true;
    }
  }

  // Overridden operators
  operator [](String? key) => key == null ? null : counties[key];
  operator []=(String key, dynamic value) => counties[key] = value; // set

  // Accessors
  List getLocations(String county) => counties[county]!.locs;
  int length() => counties.keys.length;
  String elementAt(int index) => counties.keys.elementAt(index);

  // API function
  Future<List<AccessPoint>?> refreshParkingCounts(String county) async {
    print('API CALL');
    for (var loc in counties[county]!.locs) {
      // TODO: handle errors
      await loc.getParking();
    }
    return counties[county]!.locs;
  }
}
