import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/check_user_logged_in_use_case.dart';

final splashViewModelProvider =
    AsyncNotifierProvider.autoDispose<SplashViewModel, bool>(
        SplashViewModel.new);

class SplashViewModel extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    return _checkUserLoggedIn();
  }

  Future<bool> _checkUserLoggedIn() async {
    final checkUserLoggedInUseCase = ref.read(checkUserLoggedInUseCaseProvider);
    final result = await checkUserLoggedInUseCase();
    return result is Success;
  }
}
