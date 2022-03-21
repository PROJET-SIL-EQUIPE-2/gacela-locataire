import 'package:flutter/material.dart';
import 'colors.dart';

class GacelaTheme {
  static const double hPadding = 20.0;
  static const double vPadding = 18.0;
  static ThemeData gacelaTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(
      primary: GacelaColors.gacelaBlue,
      secondary: GacelaColors.gacelaOrange,
      background: Colors.white,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: GacelaColors.gacelaGrey,
      ),
      headline5: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: GacelaColors.gacelaBlue,
      ),
    ),
  );
}
