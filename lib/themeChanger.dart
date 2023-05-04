import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/ThemeChange.dart';
import 'package:provider/provider.dart';

class ThemeChanger extends StatefulWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {

  @override
  Widget build(BuildContext context) {
      if (kDebugMode) {
        print('build themechnager');
      }
    final themeChanger = Provider.of<ThemeChange>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themes'),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme
          ),
          RadioListTile<ThemeMode>(
              title: const Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme
          ),
          RadioListTile<ThemeMode>(
              title: const Text('System Mode'),
              value: ThemeMode.system,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme
          ),
        ],
      ),
    );
  }
}
