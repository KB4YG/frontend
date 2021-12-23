import 'access_point.dart';

class Counties {
  late final Map<String, List<dynamic>> counties;
  bool hasData = false;

  // Constructor 1:
  //  Counties counties = Counties();
  //  await counties.init();
  Counties();

  // Constructor 2:
  //  Counties counties = await Counties.create()
  Counties._();
  static Future<Counties> create() async {
    Counties counties = Counties._();
    await counties.init();
    return counties;
  }

  // API Call to get all counties and corresponding locations
  Future<void> init() async {
    if (!hasData) {
      // TODO: connect API with Counties()
      print('Created New Counties()');
      counties = {
        'Linn': [
          'Loc 1',
          'Loc 2',
          'Loc 3',
          'Loc 4',
        ],
        'Benton': [
          'Fitton Green',
          'Oak Creek Preserve',
          'Bald Hill',
          'McDonald-Dunn Forest',
          'Cardwell Hill',
        ]
      };
      hasData = true;
    }
  }

  // Overridden operators
  operator [](String? key) => key == null ? null : counties[key];
  operator []=(String key, dynamic value) => counties[key] = value; // set

  // Accessors
  List getLocations(String county) => counties[county]!;
  int length() => counties.keys.length;
  String elementAt(int index) => counties.keys.elementAt(index);

  // API function
  Future<void> refreshParkingCounts(county) async {
    print('API CALL');
    int i = 0;
    for (var loc in counties[county]!) {
      if (loc is! AccessPoint) {
        print('Converted $loc to AccessPoint()');
        counties[county]![i] = AccessPoint(loc);
      }
      // TODO: handle errors
      counties[county]![i].getParking();
      i++;
    }
  }

}
