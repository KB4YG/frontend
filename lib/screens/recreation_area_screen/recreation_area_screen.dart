import 'package:flutter/material.dart';
import 'package:kb4yg/models/recreation_area.dart';
import 'package:kb4yg/providers/backend.dart';
import 'package:kb4yg/screens/recreation_area_screen/recreation_area_carousel.dart';
import 'package:kb4yg/screens/recreation_area_screen/recreation_area_info.dart';
import 'package:kb4yg/widgets/content_card.dart';
import 'package:kb4yg/widgets/loading_indicator.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../models/parking_lot.dart';
import '../../widgets/error_card.dart';
import '../../widgets/parking_lot_table.dart';
import '../../widgets/screen_template.dart';

class RecreationAreaScreen extends StatefulWidget {
  final String recAreaUrl;
  final String recAreaName;

  const RecreationAreaScreen(this.recAreaUrl, this.recAreaName, {Key? key})
      : super(key: key);

  @override
  State<RecreationAreaScreen> createState() => _RecreationAreaScreenState();
}

class _RecreationAreaScreenState extends State<RecreationAreaScreen> {
  late Future<RecreationArea> recArea;

  @override
  void initState() {
    super.initState();
    recArea = BackendProvider.of(context).getRecreationArea(widget.recAreaUrl);
  }

  void launchMap(BuildContext context, ParkingLot location) async {
    try {
      bool status = await MapsLauncher.launchQuery(location.address);
      if (status == false) throw Error();
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
        widget.recAreaName,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      child: FutureBuilder<RecreationArea>(
        future: recArea,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(
                builder: (context, constraints) => (constraints.maxWidth >= 900)
                    ? DesktopRecreationAreaScreen(recArea: snapshot.data!)
                    : MobileRecreationAreaScreen(recArea: snapshot.data!));
          } else if (snapshot.hasError) {
            return ErrorCard(
                title: 'Failed to retrieve recreation area information',
                message: snapshot.error.toString());
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}

class DesktopRecreationAreaScreen extends StatelessWidget {
  final RecreationArea recArea;

  const DesktopRecreationAreaScreen({Key? key, required this.recArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebScreenCard(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          WebRecreationAreaCarousel(
              images: recArea.imageUrls, caption: recArea.name),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RecreationAreaInfo(recArea.info),
                ),
              ),
              Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  elevation: 14,
                  child: ParkingLotTable(
                      parkingLots: recArea.parkingLots,
                      timestamp: 'Updated: 4/18/2022 @ 2:10 pm')),
            ],
          ),
        ]),
      ),
    );
  }
}

class MobileRecreationAreaScreen extends StatelessWidget {
  final RecreationArea recArea;

  const MobileRecreationAreaScreen({Key? key, required this.recArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        MobileRecreationAreaCarousel(
            images: recArea.imageUrls, caption: recArea.name),
        const SizedBox(height: 18),
        Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ParkingLotTable(
              parkingLots: recArea.parkingLots,
              timestamp: 'Updated: 4/18/2022 @ 2:10 pm'),
        ),
        const SizedBox(height: 18),
        Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RecreationAreaInfo(recArea.info),
          ),
        ),
      ]),
    );
  }
}
