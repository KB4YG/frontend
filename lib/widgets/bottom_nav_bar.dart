import 'package:flutter/material.dart';
import 'package:kb4yg/screens/about.dart';
import 'package:kb4yg/screens/help.dart';

class BottomNavBar extends StatelessWidget {
  final int navIndex;
  // final void Function(int) tapFunction;

  const BottomNavBar({required this.navIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      backgroundColor: Colors.white60,
      elevation: 0.1,
      onTap: (selectedIndex) {
        if (selectedIndex != navIndex) {
          switch (selectedIndex) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const About()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Help()));
          }
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          label: 'Parking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        )
      ],
    );
  }
}
