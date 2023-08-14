import 'package:flutter/material.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

enum AppError { unauthenticated }

extension AppErrorExtension on AppError {
  String description(BuildContext context) {
    switch (this) {
      case AppError.unauthenticated:
        return context.localizations.unauthenticatedError;
    }
  }
}
