import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/model/response/token_response.dart';
import 'package:survey_flutter/storage/secure_storage.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('TokenDataSource', () {
    late MockAuthenticationApiService mockAuthenticationApiService;
    late MockSecureStorage mockSecureStorage;
    late TokenDataSource tokenDataSource;
    final tokenResponse = TokenResponse.dummy();
    final apiToken = tokenResponse.toApiToken();

    setUp(() {
      FlutterConfig.loadValueForTesting({
        'CLIENT_ID': 'CLIENT_ID',
        'CLIENT_SECRET': 'CLIENT_SECRET',
      });

      mockSecureStorage = MockSecureStorage();
      mockAuthenticationApiService = MockAuthenticationApiService();

      tokenDataSource = TokenDataSourceImpl(
        mockSecureStorage,
        mockAuthenticationApiService,
      );
    });

    // TODO: Update
    //group('Get token without refreshing', () {
    //  test('When secureStorage returns value, it returns corresponding value',
    //      () async {
    //    final tokenResponse = TokenResponse.dummy();
    //    final apiToken = tokenResponse.toApiToken();

    //    when(mockSecureStorage.getValue(
    //      key: SecureStorageKey.apiToken,
    //      serializer: ApiTokenSerializer(),
    //    )).thenAnswer((_) async => apiToken);
    //    final result = await tokenDataSource.getToken();
    //    expect(result, apiToken);
    //  });

    //  test('When secureStorage returns error, it returns corresponding error',
    //      () async {
    //    when(mockSecureStorage.getValue(
    //      key: SecureStorageKey.apiToken,
    //      serializer: ApiTokenSerializer(),
    //    )).thenThrow(SecureStorageError.failToGetValue);
    //    expect(tokenDataSource.getToken(), throwsA(isA<SecureStorageError>()));
    //  });
    //});

    //group('Get token with refreshing', () {
    //  test(
    //      'When authenticationApiService returns value, it returns corresponding value',
    //      () async {
    //    when(mockAuthenticationApiService.refreshToken(any))
    //        .thenAnswer((_) async => tokenResponse);
    //    when(mockSecureStorage.getValue(
    //      key: SecureStorageKey.apiToken,
    //      serializer: ApiTokenSerializer(),
    //    )).thenAnswer((_) async => apiToken);

    //    final result = await tokenDataSource.getToken(forceRefresh: true);
    //    expect(result, apiToken);
    //    verify(
    //      mockSecureStorage.save(
    //          value: apiToken, key: SecureStorageKey.apiToken),
    //    ).called(1);
    //  });

    //  test(
    //      'When authenticationApiService returns error, it returns corresponding error',
    //      () async {
    //    when(mockAuthenticationApiService.refreshToken(any))
    //        .thenThrow(MockDioError());
    //    when(mockSecureStorage.getValue(
    //      key: SecureStorageKey.apiToken,
    //      serializer: ApiTokenSerializer(),
    //    )).thenAnswer((_) async => apiToken);
    //    expect(tokenDataSource.getToken(forceRefresh: true),
    //        throwsA(isA<MockDioError>()));
    //  });
    //});

    group('Set token', () {
      test(
          'When calling setToken, it calls secureStorage to save the same token',
          () async {
        await tokenDataSource.setToken(apiToken);
        verify(
          mockSecureStorage.save(
              value: apiToken, key: SecureStorageKey.apiToken),
        ).called(1);
      });
    });
  });
}
