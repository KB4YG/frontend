import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme.dart';

class ThemeIconButton extends StatelessWidget {
  const ThemeIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
        tooltip: 'Toggle theme',
        onPressed: () => themeProvider.toggleTheme(null),
        icon: themeProvider.isDark
            ? const Icon(Icons.dark_mode_outlined, color: Colors.white)
            : const Icon(Icons.light_mode_outlined, color: Colors.white));
  }
}
