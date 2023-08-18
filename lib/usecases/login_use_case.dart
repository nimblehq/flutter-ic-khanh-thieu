import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authenticationRepositoryProvider));
});

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends UseCase<LoginModel, LoginParams> {
  final AuthenticationRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<LoginModel>> call(LoginParams params) async {
    try {
      final result = await _repository.login(
        email: params.email,
        password: params.password,
      );
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
