import 'package:flutter/material.dart';

class PrimaryTextFieldDecoration extends InputDecoration {
  PrimaryTextFieldDecoration(
      {required String hintText, required TextStyle? hintTextStyle})
      : super(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          fillColor: Colors.white24,
          filled: true,
          hintText: hintText,
          hintStyle: hintTextStyle?.copyWith(color: Colors.white24),
          errorMaxLines: 2,
        );
}
