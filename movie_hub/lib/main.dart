import 'package:flutter/material.dart';
import 'common/theme_manager/theme_manager.dart';
import 'base_module/buttom_navigation_screen.dart';
import 'package:get/get.dart';
import 'base_module/watch_list/view_model/watch_list_view_model.dart';


void main() {
  runApp(

      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeDataStyle.light,
      darkTheme: ThemeDataStyle.dark,
      home: BottomNavScreen(),
    );
  }
}
