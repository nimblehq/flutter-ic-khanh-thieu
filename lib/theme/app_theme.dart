import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        fontFamily: FontFamily.neuzeit,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
      );
}
