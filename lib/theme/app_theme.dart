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
            labelSmall: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
            labelLarge: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            )),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
      );
}
