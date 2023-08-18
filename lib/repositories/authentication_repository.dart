import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/storage/secure_storage.dart';
import 'package:survey_flutter/storage/secure_storage_impl.dart';

const String _grantType = "password";

final authenticationRepositoryProvider =
    Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepositoryImpl(
    AuthenticationApiService(DioProvider().getDio()),
    ref.watch(secureStorageProvider),
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
  final SecureStorage _secureStorage;

  AuthenticationRepositoryImpl(
    this._authenticationApiService,
    this._secureStorage,
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
      await _secureStorage.save(
        value: ApiToken.from(response),
        key: SecureStorageKey.apiToken,
      );
      return response.toLoginModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
