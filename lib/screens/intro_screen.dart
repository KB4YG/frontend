import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

import '../widgets/app.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  void _onIntroEnd(BuildContext context) async {
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
        pages: [
          PageViewModel(
            title: "Testing Screen 1",
            body:
                "Many parameters are available, in next section of example all are not listed. To see all parameters available please check end of README.",
            image: Image.asset('assets/launcher/ios_icon.png', width: 200),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 19.0),
              bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              pageColor: Colors.green,
              imagePadding: EdgeInsets.zero,
            ),
          ),
          PageViewModel(
            title: "Testing Screen 2",
            body:
                "Introduction screen allow you to have a screen at launcher for example, where you can explain your app. ",
            image: Image.asset('assets/launcher/kb4yg.png', width: 200),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 19.0),
              bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              pageColor: Colors.green,
              imagePadding: EdgeInsets.zero,
            ),
          ),
          PageViewModel(
            title: "Testing Screen 3",
            body:
                "Introduction screen allow you to have a screen at launcher for example, where you can explain your app. ",
            image: Image.asset('assets/launcher/android_icon.png', width: 200),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 19.0),
              bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              pageColor: Colors.green,
              imagePadding: EdgeInsets.zero,
            ),
          )
        ],
        onDone: () => _onIntroEnd(context),
        showBackButton: false,
        showSkipButton: true,
        skip: const Text('Skip',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        next: const Text('Next',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        globalBackgroundColor: Colors.green,
        done: const Text("Done",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
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
