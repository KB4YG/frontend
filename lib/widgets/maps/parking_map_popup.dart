import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kb4yg/models/recreation_area.dart';

class ParkingMapPopup extends StatelessWidget {
  final Marker marker;
  final RecreationArea location;
  final void Function()? onTap;
  const ParkingMapPopup(
      {required this.marker,
      required this.location,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                Icons.hiking_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      location.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.lightBlueAccent,
                              offset: Offset(0, -3))
                        ], // Use shadow to create space above link underline
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.lightBlueAccent,
                        decorationThickness: 3.0,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    Text(
                      'General Parking: ${location.spots}',
                      style: const TextStyle(fontSize: 13.0),
                    ),
                    Text(
                      'Handicap Parking: ${location.handicap}',
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
