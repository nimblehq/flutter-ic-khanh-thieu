import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/uimodels/app_error.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose<LoginViewModel, void>(LoginViewModel.new);

class LoginViewModel extends AutoDisposeAsyncNotifier<void> {
  late InternetConnectionManager internetConnectionManager;

  bool isValidEmail(String? email) {
    // Just use a simple rule, no fancy Regex!
    return !(email == null || !email.contains('@'));
  }

  bool isValidPassword(String? password) {
    return !(password == null || password.length < 8);
  }

  login({required String email, required String password}) async {
    state = const AsyncLoading();
    // TODO: Integrate with API

    // Handling error part:

    // If it returns unauthorized error (401)
    //state = const AsyncError(
    //  AppError.unauthorized,
    //  StackTrace.empty,
    //);

    // If it returns timeout error, then check Internet connection
    internetConnectionManager = ref.read(internetConnectionManagerProvider);
    final isConnected = await internetConnectionManager.hasConnection();

    if (!isConnected) {
      state = const AsyncError(
        AppError.noInternetConnection,
        StackTrace.empty,
      );
    } else {
      state = const AsyncError(
        AppError.generic,
        StackTrace.empty,
      );
    }
  }

  @override
  FutureOr<void> build() {}
}
