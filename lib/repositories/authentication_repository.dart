import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/model/request/login_request.dart';

const String _grantType = "password";

final authenticationRepositoryProvider =
    Provider<AuthenticationRepository>((_) {
  return AuthenticationRepositoryImpl(
    AuthenticationApiService(DioProvider().getDio()),
  );
});

abstract class AuthenticationRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

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
