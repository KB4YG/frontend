import 'package:flutter/material.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/widgets/parking_lot_table.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../models/parking_lot.dart';
import '../widgets/error_card.dart';
import '../widgets/screen_template.dart';
import 'home_screen.dart';

class RecreationAreaScreen extends StatefulWidget {
  final String recreationAreaUrl;
  final String recreationAreaName;
  const RecreationAreaScreen(this.recreationAreaUrl, this.recreationAreaName,
      {Key? key})
      : super(key: key);

  @override
  State<RecreationAreaScreen> createState() => _RecreationAreaScreenState();
}

class _RecreationAreaScreenState extends State<RecreationAreaScreen> {
  late Future<RecreationArea> recreationArea;

  @override
  void initState() {
    super.initState();
    recreationArea =
        BackendProvider.of(context).getRecreationArea(widget.recreationAreaUrl);
  }

  void launchMap(BuildContext context, ParkingLot location) async {
    try {
      bool status = await MapsLauncher.launchQuery(location.address);
      if (status == false) {
        throw Error();
      }
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Failed to launch'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: Text(
        widget.recreationAreaName,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: FutureBuilder<RecreationArea>(
              future: recreationArea,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    RecreationAreaCarousel(images: snapshot.data!.imageUrls),
                    const SizedBox(height: 30),
                    Card(
                      elevation: 10.0,
                      shadowColor: Colors.white,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          ParkingLotTable(
                              parkingLots: snapshot.data!.parkingLots),
                          const SizedBox(height: 7),
                          const Text(
                            'Last update: today at 2:10 pm',
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 12),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RecreationAreaInfo(snapshot.data!.info)),
                  ]);
                } else if (snapshot.hasError) {
                  return ErrorCard(message: snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

class RecreationAreaCarousel extends StatelessWidget {
  final List<String> images;
  const RecreationAreaCarousel({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreenCarousel();
  }
}

class RecreationAreaInfo extends StatelessWidget {
  final String description;
  const RecreationAreaInfo(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shadowColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: const Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.6,
            indent: 0,
            endIndent: 0,
            color: Colors.black12,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: const SelectableText(
              'Fitton Green park is named after Elsie Fitton Rose,'
              ' married to her husband, Charles Ross, who funded the acquirement'
              ' of this 308-acre natural land space in partnership with Greenbelt'
              ' Land Trust, of which they were the founder. Fitton Green has been'
              ' open to the public since the Fall of 2003. ',
              style: TextStyle(fontSize: 15.0, height: 1.3, letterSpacing: 0.5),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
