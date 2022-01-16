import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kb4yg/providers/theme.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  bool isDark(context) => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SwitchListTile(
        visualDensity: VisualDensity.compact,
        title: Text('${isDark(context) ? 'Dark' : 'Light'} Mode'),
        secondary: const Icon(Icons.lightbulb_outline),
        value: themeProvider.isDark,
        onChanged: themeProvider.toggleTheme);
  }
}
