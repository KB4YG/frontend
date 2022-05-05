import 'package:beamer/beamer.dart' show Beamer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:latlong2/latlong.dart';

import '../../models/parking_lot.dart';
import '../../widgets/maps/parking_map.dart';

class CountyListMap extends StatelessWidget {
  final List<ParkingLot> parkingLots;
  final Function()? maximizeToggle;

  const CountyListMap(
      {Key? key, required this.parkingLots, this.maximizeToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: ParkingMap(
        zoom: kIsWeb ? 7.0 : 6.0,
        center: LatLng(constants.oregonLat, constants.oregonLng),
        locations: parkingLots,
        maximizeToggle: maximizeToggle,
        onTap: (BuildContext context, ParkingLot loc) {
          Beamer.of(context).beamToNamed(loc.links[constants.linkRecArea]!);
        },
        title: MediaQuery.of(context).size.width <= 500
            ? null
            : Text('Explore by Map',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: Theme.of(context).textTheme.headline4?.fontSize)),
      ),
    );
  }
}
