import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../models/county.dart';
import '../../models/parking_lot.dart';
import '../../utilities/sanitize_url.dart';
import '../../utilities/constants.dart' as constants;
import '../../widgets/maps/parking_map.dart';

class CountyMap extends StatelessWidget {
  final County county;
  final void Function()? maximizeToggle;
  const CountyMap({Key? key, required this.county, this.maximizeToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: ParkingMap(
          center: LatLng(county.lat, county.lng),
          locations: county.parkingLots,
          onTap: (BuildContext context, ParkingLot loc) {
            String route = sanitizeUrl(
                '${constants.routeLocations}/${county.name}/${loc.name}');
            Beamer.of(context).beamToNamed(route);
            // TODO: Add links to parking loc
            // Beamer.of(context).beamToNamed(loc.links.recreationArea);
          },
          maximizeToggle: maximizeToggle),
    );
  }
}
