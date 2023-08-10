import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations? get localizations => AppLocalizations.of(this);

  dismissKeyboard() {
    FocusNode currentFocusNode = FocusScope.of(this);
    if (!currentFocusNode.hasPrimaryFocus) {
      currentFocusNode.unfocus();
    }
  }
}
