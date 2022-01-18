import 'package:bulleted_list/bulleted_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/models/access_point.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:kb4yg/widgets/settings.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;


void pushLocationScreen(BuildContext context, AccessPoint loc) {
  final routeName = '${constants.routeLocation}/${loc.name.toLowerCase().replaceAll(' ', '-')}';
  print('pushLocationScreen($loc) => $routeName');
  Navigator.pushNamed(context, routeName,
      arguments: ScreenArguments(location: loc));
}

class ParkingArea extends StatelessWidget {
  final AccessPoint location;
  const ParkingArea({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //map_launcher code
    openMapsSheet(context) async {
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
                          title: location.name,
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

    //URL for Carousel images. Note I might have to change this code
    const List<String> urls = [
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg'
    ];
    //praking info
    final List<Widget> widgets = [
      const Text('Handicap Parking: 5'),
      const Text('General Parking: 5'),
      const Text('Date: 01/16/2022'),
      const Text('Time: 11:00 A.M'),
      const Text('Tempreture: 54° F|C'),
    ];
    //this is a list with all info on the parking area
    final List<Widget> parkingAreaInfo = [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.rectangle,
            ),
            child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                itemCount: urls.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(urls[itemIndex]),
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
                Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'A BackButton is an IconButton with a "back" icon appropriate for the current TargetPlatform.'
                    ' When pressed, the back button calls Navigator.maybePop to return to the previous route unless a custom'
                    'onPressed callback is provided.'),
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
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => openMapsSheet(context),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.place,
                          color: Colors.red,
                        ),
                        Text(
                          'Maps',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
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
                BulletedList(
                  listItems: widgets,
                  bulletColor: Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: Header(
        // leading: const BackButton(),
        // automaticallyImplyLeading: true,
        // centerTitle: true,
        // elevation: 0,
        title: Text(location.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      endDrawer: const Settings(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: ListView.separated(
          itemCount: parkingAreaInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return parkingAreaInfo[index];
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      // bottomNavigationBar: BottomNavBar(
      //     navBarIndex: widget.navBarIndex, loc_name: widget.loc_name),
    );
  }
}
