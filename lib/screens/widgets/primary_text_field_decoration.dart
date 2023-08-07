import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';

class PrimaryTextFieldDecoration extends InputDecoration {
  PrimaryTextFieldDecoration(
      {required String hintText, required TextStyle? hintTextStyle})
      : super(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Metrics.defaultBorderRadius),
          ),
          fillColor: Colors.white24,
          filled: true,
          hintText: hintText,
          hintStyle: hintTextStyle?.copyWith(color: Colors.white24),
          errorMaxLines: 2,
        );
}
