import 'package:flutter/material.dart';
import 'package:movie_hub/base_module/Authentication/View/login_screen.dart';
import 'common/theme_manager/theme_manager.dart';
import 'base_module/buttom_navigation_screen.dart';
import 'package:get/get.dart';
import 'base_module/watch_list/view_model/watch_list_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'common/network_connectivity_status.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'base_module/Authentication/ViewModel/AuthViewModel.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(WatchListViewModel());
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyAppController appController = Get.put(MyAppController());
  final NetworkStatusController _controller = Get.put(NetworkStatusController());
  final AuthService authService = Get.put(AuthService());


  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      locale: appController.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // Arabic
        Locale('en'), // English
        Locale('bn'), // Bangla
      ],
      themeMode: appController.themeMode,
      theme: ThemeDataStyle.light,
      darkTheme: ThemeDataStyle.dark,
      home: LoginScreen(),
    ));
  }
}

class MyAppController extends GetxController {
  // Initially set the locale to Bangla and theme mode to System
  var _locale = Locale('bn').obs;
  var _themeMode = ThemeMode.system.obs;

  // Getters for locale and theme
  Locale get locale => _locale.value;
  ThemeMode get themeMode => _themeMode.value;

  // Method to change the language
  void changeLanguage(String languageCode) {
    switch (languageCode) {
      case 'en':
        _locale.value = Locale('en');
        break;
      case 'bn':
        _locale.value = Locale('bn');
        break;
      case 'ar':
      default:
        _locale.value = Locale('ar');
        break;
    }

    // Update the locale for the app
    Get.updateLocale(_locale.value);
  }

  // Method to change the theme
  void changeTheme(ThemeMode mode) {
    _themeMode.value = mode;
  }
}
