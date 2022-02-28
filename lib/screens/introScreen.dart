import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kb4yg/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  void _onTntroEnd(context) async {
    await prefs.setBool('firstTimeDownload', false).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => App(prefs: prefs)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              image:
                  Image.asset('assets/launcher/android_icon.png', width: 200),
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
          onDone: () {
            // When done button is press
            _onTntroEnd(context);
          },
          showBackButton: false,
          showSkipButton: true,
          skip: const Text('Skip',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          next: const Text('Next',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          globalBackgroundColor: Colors.green,
          done: const Text("Done",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          dotsDecorator: DotsDecorator(
              size: const Size.square(.0),
              activeSize: const Size(50.0, 10.0),
              activeColor: Colors.white,
              color: Colors.white,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ),
      ),
    );
  }
}
