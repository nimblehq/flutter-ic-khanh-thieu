import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/uimodels/app_error.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose<LoginViewModel, void>(LoginViewModel.new);

class LoginViewModel extends AutoDisposeAsyncNotifier<void> {
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
    // For now, assume its returns error
    state = const AsyncError(
      AppError.unauthenticated,
      StackTrace.empty,
    );
  }

  @override
  FutureOr<void> build() {}
}
