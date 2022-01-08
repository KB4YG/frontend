import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kb4yg/providers/theme.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SwitchListTile(
      visualDensity: VisualDensity.compact,
      title: const Text('Dark Mode'),
      secondary: const Icon(Icons.lightbulb_outline),
      value: themeProvider.isDark,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      }
    );
  }
}