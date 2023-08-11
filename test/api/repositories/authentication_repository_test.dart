import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/response/login_response.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('AuthenticationRepositoryTest', () {
    late MockAuthenticationApiService mockAuthApiService;
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
      authRepository = AuthenticationRepositoryImpl(mockAuthApiService);
    });

    test('When login successfully, it returns correct model', () async {
      final loginResponse = LoginResponse.dummy();

      when(mockAuthApiService.login(any))
          .thenAnswer((_) async => loginResponse);

      final result =
          await authRepository.login(email: email, password: password);

      expect(result, loginResponse.toLoginModel());
    });

    test('When login fail, it returns failed exception', () async {
      when(mockAuthApiService.login(any)).thenThrow(Exception());

      final result = authRepository.login(email: email, password: password);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
