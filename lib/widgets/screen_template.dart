import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/settings.dart';

import 'mobile_app_bar.dart';
import 'navbar.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final Widget child;
  final bool hasScrollbar;
  const ScreenTemplate(
      {Key? key,
      this.title,
      this.bottom,
      required this.child,
      this.hasScrollbar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => kIsWeb
      ? WebScreenTemplate(hasScrollbar: hasScrollbar, child: child)
      : MobileScreenTemplate(
          title: title,
          bottom: bottom,
          hasScrollbar: hasScrollbar,
          child: child);
}

class MobileScreenTemplate extends StatelessWidget {
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final Widget child;
  final bool hasScrollbar;
  const MobileScreenTemplate(
      {Key? key,
      required this.title,
      this.bottom,
      required this.child,
      required this.hasScrollbar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(title: title, bottom: bottom),
      endDrawer: const Settings(),
      body: hasScrollbar
          ? Scrollbar(
              child: SingleChildScrollView(
                child: child,
              ),
            )
          : child,
    );
  }
}

class WebScreenTemplate extends StatelessWidget {
  final bool hasScrollbar;
  final Widget child;
  const WebScreenTemplate(
      {Key? key, required this.hasScrollbar, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: hasScrollbar
            ? SingleChildScrollView(
                primary: true,
                child: Column(children: [
                  const Navbar(),
                  Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 4.0),
                      child: child)
                ]))
            : Column(children: [const Navbar(), Expanded(child: child)]));
  }
}
