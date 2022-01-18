import 'package:flutter/material.dart';


class Header extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      leading: (ModalRoute.of(context)?.canPop ?? false) ? const BackButton() : null,
      actions: [
        Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Open settings menu',
            )
        )
      ]
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
