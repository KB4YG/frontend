import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kb4yg/models/access_point.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:map_launcher/map_launcher.dart';

class ParkingArea extends StatelessWidget {
  final AccessPoint location;
  const ParkingArea({Key? key, required this.location}) : super(key: key);

  //URL for Carousel images. Note I might have to change this code
  static const List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'
  ];

  // void _launchURL() async {
  void openMapsSheet(BuildContext context) async {
    try {
      final coordinates = Coords(location.lat, location.lng);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coordinates,
                        title: location.address,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: Text(
          location.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      endDrawer: const Settings(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxHeight: 400),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          itemCount: ParkingArea.urls.length,
                          itemBuilder: (context, itemIndex, pageViewIndex) =>
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                      ParkingArea.urls[itemIndex]),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Text('About',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            SelectableText(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                              ' sed do eiusmod tempor incididunt ut labore et dolore '
                              'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                              'exercitation ullamco laboris nisi ut aliquip ex ea '
                              'commodo consequat. Duis aute irure dolor in '
                              'reprehenderit in voluptate velit esse cillum dolore eu '
                              'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
                              'non proident, sunt in culpa qui officia deserunt mollit '
                              'anim id est laborum.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const Text(
                              'Location',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextButton.icon(
                              onPressed: () => openMapsSheet(context),
                              icon: const Icon(Icons.place, color: Colors.red),
                              label: const Text('Maps', textAlign: TextAlign.center),
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text(
                              'Parking Info',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SelectableText(
                              '${constants.bullet} General Parking: ${location.spots}\n'
                              '${constants.bullet} Handicap Parking: ${location.handicap}\n'
                              '${constants.bullet} Date: 01/16/2022\n'
                              '${constants.bullet} Time: 11:00 A.M\n'
                              '${constants.bullet} Temperature: 54° F',
                              style: const TextStyle(height: 2), //TODO: style text
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        ),
      ),
    );
  }
}
