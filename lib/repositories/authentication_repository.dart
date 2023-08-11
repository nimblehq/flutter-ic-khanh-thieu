import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:injectable/injectable.dart';

const String _grantType = "password";

abstract class AuthenticationRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationApiService _authenticationApiService;

  AuthenticationRepositoryImpl(this._authenticationApiService);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authenticationApiService.login(LoginRequest(
        email: email,
        password: password,
        clientId: Env.clientId,
        clientSecret: Env.clientSecret,
        grantType: _grantType,
      ));
      return response.toLoginModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
