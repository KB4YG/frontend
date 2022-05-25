import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kb4yg/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static const PageDecoration decoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  static const TextStyle buttonStyle =
      TextStyle(fontWeight: FontWeight.w600, color: Colors.white);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _index = 0;

  void onIntroEnd(BuildContext context) async {
    var prefs = Provider.of<SharedPreferences>(context, listen: false);
    await prefs.setBool(constants.prefIntro, false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const App()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        onChange: (index) => setState(() => _index = index),
        pages: [
          PageViewModel(
            title: 'Check Parking Availability',
            body: 'Before traveling to a recreation area, check parking '
                'availability to ensure that you find a parking space upon arrival.',
            image: Image.asset('assets/intro/intro-1.png', width: 230),
            decoration: IntroScreen.decoration,
          ),
          PageViewModel(
            title: 'Be Aware of Fire Danger',
            body: 'View the likelihood of fire ignition for a recreation area '
                'to make informed decisions and stay safe.',
            image: Image.asset('assets/intro/intro-2.png', width: 230),
            decoration: IntroScreen.decoration,
          ),
          PageViewModel(
            title: 'Scope Out Beautiful Landscapes',
            body: 'View images of recreation areas to help decide where to go.',
            image: Image.asset('assets/intro/intro-3.png', width: 230),
            decoration: IntroScreen.decoration,
          ),
          PageViewModel(
            title: 'View Maps and Directions',
            body: 'Locate recreation areas near you using our map, and '
                'get directions to natural sites with the click of a button!',
            image: Image.asset('assets/intro/intro-4.png', width: 230),
            decoration: IntroScreen.decoration,
          ),
        ],
        onDone: () => onIntroEnd(context),
        showBackButton: _index != 0,
        showSkipButton: _index == 0,
        skip: const Text('Skip', style: IntroScreen.buttonStyle),
        back: const Text('Back', style: IntroScreen.buttonStyle),
        next: const Text('Next', style: IntroScreen.buttonStyle),
        done: const Text('Done', style: IntroScreen.buttonStyle),
        globalBackgroundColor: Colors.green,
        dotsDecorator: DotsDecorator(
            size: const Size.square(.0),
            activeSize: const Size(50.0, 10.0),
            activeColor: Colors.white,
            color: Colors.white,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
