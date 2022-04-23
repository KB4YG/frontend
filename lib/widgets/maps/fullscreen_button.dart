import 'package:flutter/material.dart';

class FullscreenButton extends StatefulWidget {
  final void Function()? maximizeToggle;

  const FullscreenButton({Key? key, required this.maximizeToggle})
      : super(key: key);

  @override
  _FullscreenButtonState createState() => _FullscreenButtonState();
}

class _FullscreenButtonState extends State<FullscreenButton> {
  final _icons = [
    const Icon(Icons.fullscreen),
    const Icon(Icons.fullscreen_exit)
  ];
  int _iconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        tooltip: 'Toggle fullscreen',
        heroTag: 'fullscreen',
        onPressed: () {
          // Doesn't call set state since maximizeToggle() is assumed to do so
          _iconIndex = _iconIndex == 0 ? 1 : 0;
          widget.maximizeToggle?.call();
        },
        child: _icons[_iconIndex]);
  }
}
