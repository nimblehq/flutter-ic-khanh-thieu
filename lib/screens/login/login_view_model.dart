import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/uimodels/app_error.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose<LoginViewModel, void>(LoginViewModel.new);

class LoginViewModel extends AutoDisposeAsyncNotifier<void> {
  late LoginUseCase loginUseCase;
  late InternetConnectionManager internetConnectionManager;

  bool isValidEmail(String? email) {
    // Just use a simple rule, no fancy Regex!
    return !(email == null || !email.contains('@'));
  }

  bool isValidPassword(String? password) {
    return !(password == null || password.length < 8);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    if (result is Success) {
      state = const AsyncData(null);
    } else if (result is Failed) {
      final error = result as Failed;
      final exception = error.exception.actualException as NetworkExceptions;

      if (exception is BadRequest || exception is UnauthorisedRequest) {
        state = const AsyncError(
          AppError.unauthorized,
          StackTrace.empty,
        );
        return;
      } else if (exception is RequestTimeout) {
        final isConnected = await _hasInternetConnection();
        if (!isConnected) {
          state = const AsyncError(
            AppError.noInternetConnection,
            StackTrace.empty,
          );
          return;
        }
      }

      state = const AsyncError(
        AppError.generic,
        StackTrace.empty,
      );
    }
  }

  Future<bool> _hasInternetConnection() async {
    internetConnectionManager = ref.read(internetConnectionManagerProvider);
    return await internetConnectionManager.hasConnection();
  }

  @override
  FutureOr<void> build() {}
}
