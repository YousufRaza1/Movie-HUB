import 'package:flutter/material.dart';

class ThemeDataStyle {
  // Light Theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      primary: Colors.deepPurple.shade200,         // Primary color
      onPrimary: Colors.white,                     // Text color on primary
      secondary: Colors.deepPurple.shade300,       // Secondary color
      onSecondary: Colors.white,                   // Text color on secondary
      surface: Colors.grey.shade100,               // Surface color (cards, sheets)
      onSurface: Colors.black,                  // Text color on background
      error: Colors.red.shade400,                  // Error color
      onError: Colors.white,                       // Text color on error
      brightness: Brightness.light,                // Brightness (light mode)
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      primary: Colors.deepPurple.shade500,         // Primary color
      onPrimary: Colors.white,                     // Text color on primary
      secondary: Colors.deepPurple.shade700,       // Secondary color
      onSecondary: Colors.white,                   // Text color on secondary
      surface: Colors.grey.shade900,               // Surface color (cards, sheets)
      onSurface: Colors.white,                  // Text color on background
      error: Colors.red.shade800,                  // Error color
      onError: Colors.black,                       // Text color on error
      brightness: Brightness.dark,                 // Brightness (dark mode)
    ),
  );
}