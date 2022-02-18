// import 'package:kb4yg/models/county.dart';
// import 'package:kb4yg/models/recreation_area.dart';
//
// class Counties {
//   final String state;
//   final Map<String, County> counties;
//
//   Counties(this.counties, {this.state = 'OR'});
//
//   Counties.fromJson(Map<String, dynamic> json, {this.state = 'OR'})
//       : counties = {} {
//     for (MapEntry e in json.entries) {
//       counties[e.key] = County.fromJson(e.value);
//     }
//   }
//
//   // Getters
//   int get length => counties.length;
//   List<RecreationArea>? getRecreationAreas(String county) =>
//       counties[county]?.recreationAreas;
//   String elementAt(int index) => counties.keys.elementAt(index);
//
//   // Overridden operators
//   operator [](String? key) => key == null ? null : counties[key];
//   operator []=(String key, dynamic value) => counties[key] = value;
// }
