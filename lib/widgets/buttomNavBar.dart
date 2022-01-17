import 'package:flutter/material.dart';
import 'package:kb4yg/screens/about.dart';
import 'package:kb4yg/screens/help.dart';
import 'package:kb4yg/screens/parking_Info.dart';
import 'package:kb4yg/screens/parking_area.dart';

class BottonNavBar extends StatefulWidget {
  const BottonNavBar(
      {Key? key, required this.navBarIndex, required this.loc_name})
      : super(key: key);
  final int navBarIndex;
  final String loc_name;
  @override
  _BottonNavBarState createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar> {
  void _onItemTapped(int index) {
    List<Widget> screen = [
      const ParkingInfo(),
      Help(loc_name: widget.loc_name, navBarIndex: index),
      About(loc_name: widget.loc_name, navBarIndex: index),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.directions_car,
          ),
          label: 'Parking',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.help_outline,
          ),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.info,
          ),
          label: 'About',
        )
      ],
      currentIndex: widget.navBarIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      backgroundColor: Colors.white60,
      elevation: 0.1,
      onTap: _onItemTapped,
    );
  }
}
