import 'package:flutter/material.dart';
import 'package:kb4yg/providers/theme.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SwitchListTile(
        activeColor: Theme.of(context).indicatorColor,
        visualDensity: VisualDensity.compact,
        title: Text('${themeProvider.isDark ? 'Dark' : 'Light'} Mode'),
        secondary: themeProvider.isDark
            ? const Icon(Icons.dark_mode_outlined, color: Colors.white)
            : const Icon(Icons.light_mode_outlined, color: Colors.black),
        value: themeProvider.isDark,
        onChanged: themeProvider.toggleTheme);
  }
}
