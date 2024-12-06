import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_hub/base_module/Authentication/View/login_screen.dart';
import 'package:movie_hub/base_module/Settings/View/setting_screen.dart';
import 'common/theme_manager/theme_manager.dart';
import 'package:get/get.dart';
import 'base_module/watch_list/view_model/watch_list_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'common/network_connectivity_status.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'base_module/Authentication/ViewModel/AuthViewModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.data['screen']}');
}

void requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
  final NetworkStatusController _controller =
      Get.put(NetworkStatusController());
  final AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
      Get.to(SettingsScreen());
    });

    // Fetch the FCM token for the device (optional)
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
  }

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
  var _locale = Locale('en').obs;
  var _themeMode = ThemeMode.system.obs;

  Locale get locale => _locale.value;

  ThemeMode get themeMode => _themeMode.value;

  Rx<String> userSelectedLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setPreferedLanguage();
    observeSystemLocaleChanges();
  }

  void setPreferedLanguage() async {
    print('Language init called');
    var userSelectedPreference = await fetchPreferredLanguage();
    if (userSelectedPreference == null) {
      _locale.value = Locale('en');
    } else {
      changeLanguage(userSelectedPreference);
      userSelectedLanguage.value = userSelectedPreference;
    }
  }

  void observeSystemLocaleChanges() {
    PlatformDispatcher.instance.onLocaleChanged = () {
      print('System locale changed: ${PlatformDispatcher.instance.locale}');
      selectLanguageForSystem();
    };
  }

  Future<void> savePreferredLanguage(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', languageCode);
  }

  Future<String?> fetchPreferredLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('preferred_language');
  }

  void selectLanguageForSystem() {
    Locale updatedLocale = PlatformDispatcher.instance.locale;

    if (updatedLocale.languageCode == 'en') {
      _locale.value = Locale('en');
    } else if (updatedLocale.languageCode == 'bn') {
      _locale.value = Locale('bn');
    } else if (updatedLocale.languageCode == 'ar') {
      _locale.value = Locale('ar');
    } else {
      _locale.value = Locale('system');
    }

    // Notify GetX and update app locale
    Get.updateLocale(_locale.value);
  }

  void changeLanguage(String languageCode) {
    Locale systemLocale = PlatformDispatcher.instance.locale;
    print(
        'System language: ${systemLocale.languageCode}-${systemLocale.countryCode}');

    switch (languageCode) {
      case 'system':
        selectLanguageForSystem();
        userSelectedLanguage.value = 'system';
        break;
      case 'en':
        _locale.value = Locale('en');
        savePreferredLanguage('en');
        userSelectedLanguage.value = 'en';
        break;
      case 'bn':
        _locale.value = Locale('bn');
        savePreferredLanguage('bn');
        userSelectedLanguage.value = 'bn';
        break;
      case 'ar':
        _locale.value = Locale('ar');
        savePreferredLanguage('ar');
        userSelectedLanguage.value = 'ar';
        break;
      default:
        _locale.value = Locale('en');
        savePreferredLanguage('en');
        userSelectedLanguage.value = 'en';
        break;
    }

    Get.updateLocale(_locale.value);
  }

  void changeTheme(ThemeMode mode) {
    _themeMode.value = mode;
  }
}
