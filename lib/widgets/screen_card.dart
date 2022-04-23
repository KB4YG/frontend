import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class ScreenCard extends StatelessWidget {
  final Widget? child;

  const ScreenCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebScreenCard(child: child)
        : MobileScreenCard(child: child);
  }
}

class WebScreenCard extends StatelessWidget {
  final Widget? child;

  const WebScreenCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: child,
    );
  }
}

class MobileScreenCard extends StatelessWidget {
  final Widget? child;

  const MobileScreenCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: child,
    );
  }
}
