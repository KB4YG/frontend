import 'package:kb4yg/models/recreation_area.dart';

class County {
  final String name;
  final List<RecreationArea> locs;
  const County(this.name, {required this.locs});

  @override
  String toString() => name;

  // API function
  Future<void> refreshParking() async {
    print('API CALL');
    for (var loc in locs) {
      // TODO: handle errors
      await loc.getParking();
    }
    // return locs;
  }
}
