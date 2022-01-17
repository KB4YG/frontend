import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/bottom_nav_bar.dart';
import 'package:kb4yg/widgets/settings.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        title: const Text('About',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      endDrawer: const Settings(),
      body: const Center(
        child: Text('data'),
      ),
      bottomNavigationBar: const BottomNavBar(navIndex: 1),
    );
  }
}
