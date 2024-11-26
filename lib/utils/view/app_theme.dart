import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class AppTheme {

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    // Set the universal font to Raleway
    fontFamily: 'Raleway',  // This is the font family name defined in pubspec.yaml

    colorScheme: ColorScheme.fromSeed(seedColor: PaletteColor.darkBlue),
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
