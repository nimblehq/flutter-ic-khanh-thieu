import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/model/request/refresh_token_request.dart';
import 'package:survey_flutter/storage/secure_storage.dart';
import 'package:survey_flutter/storage/secure_storage_impl.dart';

final tokenDataSourceProvider = Provider<TokenDataSource>((ref) {
  return TokenDataSourceImpl(ref.watch(secureStorageProvider),
      AuthenticationApiService(DioProvider().getDio()));
});

abstract class TokenDataSource {
  Future<ApiToken> getToken({bool forceRefresh});
  Future<void> overwriteToken(ApiToken token);
}

class TokenDataSourceImpl extends TokenDataSource {
  final SecureStorage _secureStorage;
  final AuthenticationApiService _authenticationApiService;
  final String _grantType = 'refresh_token';

  TokenDataSourceImpl(
    this._secureStorage,
    this._authenticationApiService,
  );

  @override
  Future<ApiToken> getToken({bool forceRefresh = false}) async {
    if (forceRefresh) {
      final tokenResponse = await _authenticationApiService.refreshToken(
        RefreshTokenRequest(
          grantType: _grantType,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
        ),
      );
      final apiToken = tokenResponse.toApiToken();
      await _secureStorage.save(
        value: apiToken,
        key: SecureStorageKey.apiToken,
      );
      return apiToken;
    }

    return await _secureStorage.getValue(key: SecureStorageKey.apiToken)
        as ApiToken;
  }

  @override
  Future<void> overwriteToken(ApiToken token) async {
    await _secureStorage.save(value: token, key: SecureStorageKey.apiToken);
  }
}