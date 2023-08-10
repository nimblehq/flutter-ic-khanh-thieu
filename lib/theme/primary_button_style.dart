import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';

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
              borderRadius: BorderRadius.circular(Metrics.defaultBorderRadius),
            ),
          ),
        );
}
