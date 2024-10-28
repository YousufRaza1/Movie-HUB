import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_hub/base_module/Authentication/View/login_screen.dart';
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
          _logoutMenuItme(context)

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

  Widget _logoutMenuItme(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Logout',style: TextStyle(color: Colors.red))
        ,
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Get.offAll(() => LoginScreen());
        },
      ),
    );
  }
}













