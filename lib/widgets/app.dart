import 'package:flutter/material.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:kb4yg/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kb4yg/counties.dart';
import 'package:kb4yg/screens/loading.dart';
import 'package:kb4yg/screens/select_county.dart';
import 'package:kb4yg/screens/parking_Info.dart';
import 'package:kb4yg/utilities/constants.dart' as constants;

class App extends StatelessWidget {
  static const title = 'Know Before You Go';
  final SharedPreferences prefs;
  final Counties counties;
  const App({Key? key, required this.prefs, required this.counties})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          // Check if user selected a county during previous app use
          final String? selectedCounty = prefs.getString(constants.prefCounty);
          final themeProvider = Provider.of<ThemeProvider>(context);
          themeProvider.initTheme(prefs: prefs);

          return MaterialApp(
              title: title,
              themeMode: themeProvider.themeMode,
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              routes: {
                '/': (context) => Loading(
                      selectedCounty: selectedCounty,
                      counties: counties,
                    ),
                constants.navHome: (context) => const Home(title: title),
                constants.navSelectCounty: (context) =>
                    SelectCounty(prefs: prefs, counties: counties),
                constants.navParkingInfo: (context) => const ParkingInfo(),
              });
        },
      );
}
