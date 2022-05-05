import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../models/county.dart';
import '../../models/parking_lot.dart';
import '../../utilities/constants.dart' as constants;
import '../../widgets/maps/parking_map.dart';

class CountyMap extends StatelessWidget {
  final County county;
  final void Function()? maximizeToggle;
  const CountyMap({Key? key, required this.county, this.maximizeToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: ParkingMap(
          title: (kIsWeb &&
                  !isWideScreen &&
                  MediaQuery.of(context).size.width > 600)
              ? Text(
                  '${county.name} County',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.grey.shade200),
                )
              : null,
          center: LatLng(county.lat, county.lng),
          locations: county.parkingLots,
          onTap: (BuildContext context, ParkingLot loc) {
            Beamer.of(context).beamToNamed(loc.links[constants.linkRecArea]!);
          },
          maximizeToggle: maximizeToggle),
    );
  }
}
