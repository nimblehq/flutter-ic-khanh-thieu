import 'dart:async';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/repository/authentication_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

@Injectable()
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