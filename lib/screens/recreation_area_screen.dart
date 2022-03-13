import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/widgets/parkinglot_table.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../models/parking_lot.dart';
import '../widgets/error_card.dart';

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
  get recreationAreaUrl => widget.recreationAreaUrl;
  late Future<RecreationArea> futureRecreationArea;

  @override
  void initState() {
    super.initState();
    futureRecreationArea =
        BackendProvider.of(context).getRecreationArea(recreationAreaUrl);
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
    return Scaffold(
      appBar: Header(
        title: Text(
          widget.recreationAreaName,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      endDrawer: const Settings(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: FutureBuilder<RecreationArea>(
                        future: futureRecreationArea,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RecreationAreaCarousel(
                                      images: snapshot.data!.imageUrls),
                                  const SizedBox(height: 30),
                                  Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: RecreationAreaInfo(
                                          snapshot.data!.info)),
                                  const SizedBox(height: 30),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      shape: BoxShape.rectangle,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      ParkingLotTable(
                                          parkingLots:
                                              snapshot.data!.parkingLots),
                                      const SizedBox(height: 7),
                                      const Text(
                                        'Last update: today at 2:10 pm',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12),
                                      )
                                    ]),
                                  )
                                ]);
                          } else if (snapshot.hasError) {
                            return ErrorCard(
                                message: snapshot.error.toString());
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class RecreationAreaCarousel extends StatelessWidget {
  final List<String> images;
  const RecreationAreaCarousel({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: CarouselSlider.builder(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          itemCount: images.length,
          itemBuilder: (context, itemIndex, pageViewIndex) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(images[itemIndex]),
                  ),
                ),
              )),
    );
  }
}

class RecreationAreaInfo extends StatelessWidget {
  final String description;
  const RecreationAreaInfo(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: const [
          Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SelectableText(
              'Fitton Green park is named after Elsie Fitton Rose,'
              ' married to her husband, Charles Ross, who funded the acquirement'
              ' of this 308-acre natural land space in partnership with Greenbelt'
              ' Land Trust, of which they were the founder. Fitton Green has been'
              ' open to the public since the Fall of 2003. ',
              style:
                  TextStyle(fontSize: 15.0, height: 1.3, letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

// class RecreationAreaParking extends StatelessWidget {
//   const RecreationAreaParking({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         shape: BoxShape.rectangle,
//       ),
//       padding: const EdgeInsets.all(10),
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: [
//           const Text(
//             'Location',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextButton.icon(
//             onPressed: () => {}, //launchMap(context, ), //TODO
//             icon: const Icon(Icons.place, color: Colors.red),
//             label: const Text('Maps', textAlign: TextAlign.center),
//             style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//                 backgroundColor: MaterialStateProperty.all(Colors.blue)),
//           )
//         ],
//       ),
//     );
//   }
// }
