import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/response/token_response.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('AuthenticationRepositoryTest', () {
    late MockAuthenticationApiService mockAuthApiService;
    late MockTokenDataSource mockTokenDataSource;
    late AuthenticationRepositoryImpl authRepository;

    const email = "email";
    const password = "password";

    setUpAll(() {
      FlutterConfig.loadValueForTesting({
        'CLIENT_ID': 'CLIENT_ID',
        'CLIENT_SECRET': 'CLIENT_SECRET',
      });
    });

    setUp(() {
      mockAuthApiService = MockAuthenticationApiService();
      mockTokenDataSource = MockTokenDataSource();
      authRepository = AuthenticationRepositoryImpl(
        mockAuthApiService,
        mockTokenDataSource,
      );
    });

    test('When login successfully, it returns correct model', () async {
      final loginResponse = TokenResponse.dummy();

      when(mockAuthApiService.login(any))
          .thenAnswer((_) async => loginResponse);

      final result =
          await authRepository.login(email: email, password: password);

      expect(result, loginResponse.toLoginModel());
      verify(
        mockTokenDataSource.setToken(
          loginResponse.toApiToken(),
        ),
      ).called(1);
    });

    test('When login fail, it returns failed exception', () async {
      when(mockAuthApiService.login(any)).thenThrow(Exception());

      final result = authRepository.login(email: email, password: password);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
