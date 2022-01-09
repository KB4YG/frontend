import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kb4yg/providers/theme.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  static bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SwitchListTile(
      visualDensity: VisualDensity.compact,
      title: Text('${_isDark ? 'Dark' : 'Light'} Mode'),
      secondary: const Icon(Icons.lightbulb_outline),
      value: themeProvider.isDark,
      onChanged: (value) {
        setState(() {
          _isDark = value;
        });
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      }
    );
  }
}