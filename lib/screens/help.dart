import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/buttomNavBar.dart';
import 'package:kb4yg/widgets/settings.dart';

class Help extends StatefulWidget {
  const Help({Key? key, required this.loc_name, required this.navBarIndex})
      : super(key: key);
  final String loc_name;
  final int navBarIndex;
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String screenName = 'Help';
  //static int navBarIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        title: Text(
          screenName,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      endDrawer: const Settings(),
      body: const Center(
        child: Text('data'),
      ),
      bottomNavigationBar:
          BottonNavBar(navBarIndex: widget.navBarIndex, loc_name: widget.loc_name),
    );
  }
}
