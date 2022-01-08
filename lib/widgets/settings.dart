import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/theme_switch.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Settings',
      child: ListView(children: const [
        SizedBox(
          height: 55,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            child: Center(
                child: Text('Settings',textScaleFactor: 1.2)
            ),
          ),
        ),
        ThemeSwitch()
      ]));
  }
}
