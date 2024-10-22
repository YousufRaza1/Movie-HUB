import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart'; // Ensure this imports your MyAppController
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeScreen extends StatefulWidget {
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final MyAppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.themes),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display current selected theme
            Text(
              '${AppLocalizations.of(context)!.currentTheme}: ${_getThemeName(appController.themeMode)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Theme options
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.systemTheme),
                    onTap: () {
                      appController.changeTheme(ThemeMode.system);
                      setState(() {}); // Refresh the UI
                    },
                    trailing: appController.themeMode == ThemeMode.system
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.lightTheme),
                    onTap: () {
                      appController.changeTheme(ThemeMode.light);
                      setState(() {}); // Refresh the UI
                    },
                    trailing: appController.themeMode == ThemeMode.light
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.darkTheme),
                    onTap: () {
                      appController.changeTheme(ThemeMode.dark);
                      setState(() {}); // Refresh the UI
                    },
                    trailing: appController.themeMode == ThemeMode.dark
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return AppLocalizations.of(context)!.systemTheme;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.lightTheme;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.darkTheme;
      default:
        return '';
    }
  }
}
