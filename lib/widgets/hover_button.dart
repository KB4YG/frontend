import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget? child;
  final Color hoverColor;
  final bool inverted;
  const HoverButton(
      {Key? key,
      this.child,
      this.hoverColor = Colors.white,
      this.inverted = false})
      : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  late bool showBorder = widget.inverted;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: widget.hoverColor, width: 2))
            : null,
      ),
      child: InkWell(
        onTap: () {},
        onHover: (hovered) {
          setState(() {
            showBorder = widget.inverted ? !hovered : hovered;
          });
        },
        child: widget.child,
      ),
    );
  }
}
