import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/buttomNavBar.dart';
import 'package:kb4yg/widgets/settings.dart';

class About extends StatefulWidget {
  const About({Key? key, required this.loc_name, required this.navBarIndex})
      : super(key: key);
  final String loc_name;
  final int navBarIndex;
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String screenName = 'About';
  //static int navBarIndex = 2;
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
      bottomNavigationBar: BottonNavBar(
          navBarIndex: widget.navBarIndex, loc_name: widget.loc_name),
    );
  }
}
