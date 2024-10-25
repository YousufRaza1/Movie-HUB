// import 'package:flutter/material.dart';
// import 'package:weather_track/BaseModule/Authentication/View/forget_password_screen.dart';
// import '../../MainWeatherScreen/View/WeatherMainScreen.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//      WeatherScreen(),
//     const ForgetPasswordScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'Maps',
//           ),
//         ],
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'This is the Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
//
// class ForgetPasswordScreen extends StatelessWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Comimg soon',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }