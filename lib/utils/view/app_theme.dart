import 'package:flutter/material.dart';

class AppTheme {

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    // Set the universal font to Raleway
    fontFamily: 'Raleway',  // This is the font family name defined in pubspec.yaml

    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003659)),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  // Dark Them (TO EDIT)
  /*
  static ThemeData darkTheme = ThemeData(
    // Set the universal font to Raleway
    fontFamily: 'Raleway',  // This is the font family name you defined in pubspec.yaml

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
   */
}
