import 'package:flutter/material.dart';
import 'package:kb4yg/counties.dart';
import 'package:kb4yg/utilities/screen_arguments.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

// TODO: remove or remake loading.dart

class Loading extends StatefulWidget {
  final String? selectedCounty;
  final Counties counties;
  const Loading({Key? key, this.selectedCounty, required this.counties}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void pushScreen() async {
    // If user has run app before and selected a county, push ParkingInfo() screen
    // Else, push SelectCounty screen
    String screen;
    if (widget.selectedCounty == null) {
      screen = constants.routeHome;
    } else {
      screen = constants.routeParkingName;
      await widget.counties.refreshParkingCounts(widget.selectedCounty!);
    }

    // Replace loading screen with landing screen
    Navigator.pushReplacementNamed(context, screen,
      arguments: ScreenArguments(county: widget.counties[widget.selectedCounty])
    );
  }

  @override
  void initState() {
    super.initState();
    // Wait for widget to finish binding before pushing next screen
    Future.delayed(Duration.zero,() async {
      pushScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(
      backgroundColor: Colors.lightGreen,
      color: Colors.lightGreenAccent,
    ));
  }
}
