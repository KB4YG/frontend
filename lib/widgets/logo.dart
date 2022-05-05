import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff0f1f1),
        shape: BoxShape.circle,
        border:
            Border.all(width: 2.2, color: Theme.of(context).primaryColorLight),
      ),
      padding: const EdgeInsets.all(3),
      child: Image.asset(
        'assets/leaf-logo.png',
        filterQuality: FilterQuality.medium,
        width: 30,
        height: 30,
      ),
    );
  }
}
