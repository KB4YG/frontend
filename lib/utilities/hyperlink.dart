import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'launch_url.dart';

TextSpan Hyperlink(
    {required String text, String? url, Color? color = Colors.blue}) {
  url = url ?? text;
  return TextSpan(
      style: TextStyle(color: color),
      text: text,
      mouseCursor: SystemMouseCursors.click,
      recognizer: TapGestureRecognizer()..onTap = () => launchURL(url!));
}
