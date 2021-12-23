import 'package:kb4yg/access_point.dart';

const argCounty = 'county';
const argLocations = 'locations';

class ScreenArguments {
  final String? county;
  final List<AccessPoint>? locations;

  ScreenArguments({this.county, this.locations});
}