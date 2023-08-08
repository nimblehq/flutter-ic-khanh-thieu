import 'package:flutter/material.dart';

class KeyboardManager {
  static dismiss(BuildContext context) {
    FocusNode currentFocusNode = FocusScope.of(context);
    if (!currentFocusNode.hasPrimaryFocus) {
      currentFocusNode.unfocus();
    }
  }
}
