import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_setting_screen.dart';
import 'theme_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildMenuItem(context, AppLocalizations.of(context)!.languages, LanguagesScreen()),
          _buildMenuItem(context, AppLocalizations.of(context)!.themes, ThemeScreen()),
          _buildMenuItem(context, AppLocalizations.of(context)!.account, AccountScreen()),
          _buildMenuItem(context, AppLocalizations.of(context)!.about, AboutScreen()),
          _buildMenuItem(context, AppLocalizations.of(context)!.help, HelpScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Widget screen) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Get.to(screen);
        },
      ),
    );
  }
}








class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Text('Account settings go here.'),
      ),
    );
  }
}


class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text('About information goes here.'),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: Text('Help information goes here.'),
      ),
    );
  }
}
