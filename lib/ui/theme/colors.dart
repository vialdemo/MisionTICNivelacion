import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff7e57c2);
  static const Color darkPrimaryColor = Color(0xff4d2c91);
  static const Color accentColor = Color(0xff7e57c2);
  static const Color lightPrimaryColor = Color(0xFF629749);
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const ColorScheme lightScheme = ColorScheme.light(
    primary: primaryColor,
    primaryContainer: darkPrimaryColor,
    secondary: accentColor,
  );

  static const ColorScheme darkScheme = ColorScheme.dark(
    primary: primaryColor,
    primaryContainer: darkPrimaryColor,
    secondary: accentColor,
  );
}
