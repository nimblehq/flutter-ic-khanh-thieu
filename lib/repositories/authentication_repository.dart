import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/model/request/login_request.dart';

const String _grantType = "password";

final authenticationRepositoryProvider =
    Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepositoryImpl(
    AuthenticationApiService(DioProvider().getDio()),
    ref.watch(tokenDataSourceProvider),
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
  final TokenDataSource _tokenDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationApiService,
    this._tokenDataSource,
  );

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
      await _tokenDataSource.setToken(response.toApiToken());
      print("@@@ settoken ${response.toApiToken()}");
      return response.toLoginModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
