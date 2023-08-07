import 'package:flutter/material.dart';

class PrimaryButtonStyle extends ButtonStyle {
  PrimaryButtonStyle({required TextStyle? hintTextStyle})
      : super(
          textStyle: MaterialStateProperty.all(
            hintTextStyle,
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.black12),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
}
