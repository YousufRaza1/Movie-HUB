import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart'; // Ensure this imports your MyAppController
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final MyAppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languages),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: [
            // Display current selected language
            Text(
              '${AppLocalizations.of(context)!.currentLanguage}: ${appController.locale.languageCode.toUpperCase()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Language options
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('English'),
                    onTap: () {
                      appController.changeLanguage('en');
                      setState(() {
                        final langu = appController.fetchPreferredLanguage();
                        print('userprefered = ${langu}');
                      }); // Refresh the UI
                    },
                    trailing: appController.userSelectedLanguage == 'en'
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    title: Text('বাংলা'),
                    onTap: () {
                      appController.changeLanguage('bn');
                      setState(() {
                        final langu = appController.fetchPreferredLanguage();
                        print('userprefered = ${langu}');
                      }); // Refresh the UI
                    },
                    trailing: appController.userSelectedLanguage == 'bn'
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    title: Text('عربي'),
                    onTap: () {
                      appController.changeLanguage('ar');
                      setState(() {
                        final langu = appController.fetchPreferredLanguage();
                        print('userprefered = ${langu}');
                      }); // Refresh the UI
                    },
                    trailing: appController.userSelectedLanguage == 'ar'
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    title: Text('System'),
                    onTap: () {
                      appController.changeLanguage('system');
                      setState(() async {
                        final langu =
                        await appController.fetchPreferredLanguage();
                        print('userprefered = ${langu}');
                      }); // Refresh the UI
                    },
                    trailing: appController.userSelectedLanguage == 'system'
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  )
                ],
              ),
            ),
          ],
        ),)
      ),
    );
  }
}
