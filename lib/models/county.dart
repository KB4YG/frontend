import 'package:kb4yg/models/access_point.dart';

class County {
  final String name;
  final List<AccessPoint> locs;
  const County(this.name, {required this.locs});

  @override
  String toString() => name;
}