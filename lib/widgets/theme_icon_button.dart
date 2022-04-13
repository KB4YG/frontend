import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme.dart';

class ThemeIconButton extends StatefulWidget {
  const ThemeIconButton({Key? key}) : super(key: key);

  @override
  State<ThemeIconButton> createState() => _ThemeIconButtonState();
}

class _ThemeIconButtonState extends State<ThemeIconButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
        tooltip: 'Toggle theme',
        onPressed: () => themeProvider.toggleTheme(null),
        icon: themeProvider.isDark
            ? const Icon(Icons.dark_mode, color: Colors.white)
            : const Icon(Icons.light_mode, color: Colors.white));
  }
}
