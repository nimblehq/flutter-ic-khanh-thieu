import 'package:flutter/material.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

enum AppError {
  unauthorized,
  noInternetConnection,
  generic,
}

extension AppErrorExtension on AppError {
  String description(BuildContext context) {
    switch (this) {
      case AppError.unauthorized:
        return context.localizations.unauthorizedError;
      case AppError.noInternetConnection:
        return context.localizations.noInternetConnectionError;
      case AppError.generic:
        return context.localizations.genericError;
    }
  }
}
