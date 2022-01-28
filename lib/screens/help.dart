import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/header.dart';
import 'package:kb4yg/widgets/icon_key_table.dart';
import 'package:kb4yg/widgets/settings.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: SelectableText('Help')),
      endDrawer: const Settings(),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            children: const [IconKeyTable()],
          ),
        ),
      ),
    );
  }
}
