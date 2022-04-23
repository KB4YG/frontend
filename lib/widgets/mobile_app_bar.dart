import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final PreferredSizeWidget? bottom;

  const MobileAppBar({Key? key, required this.title, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold.of(context);
    return AppBar(
        title: title,
        centerTitle: true,
        bottom: bottom,
        leading: (!(scaffold.isEndDrawerOpen) && Beamer.of(context).canBeamBack)
            ? BackButton(onPressed: () => Beamer.of(context).beamBack())
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => scaffold.openEndDrawer(),
            tooltip: 'Open settings menu',
          )
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height +
      (bottom == null ? 0.0 : bottom!.preferredSize.height));
}
