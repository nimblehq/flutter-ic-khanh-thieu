import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/response/token_response.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/check_user_logged_in_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('CheckUserLoggedInUseCase', () {
    late MockTokenDataSource mockTokenDataSource;
    late CheckUserLoggedInUseCase useCase;

    setUp(() {
      mockTokenDataSource = MockTokenDataSource();
      useCase = CheckUserLoggedInUseCase(mockTokenDataSource);
    });

    test('When tokenDataSource could return a token, it returns success',
        () async {
      final token = TokenResponse.dummy().toApiToken();
      when(mockTokenDataSource.getToken()).thenAnswer((_) async => token);
      final result = await useCase();
      expect((result as Success).value, true);
    });

    test('When tokenDataSource couldn\'t return a token, it returns failed',
        () async {
      when(mockTokenDataSource.getToken()).thenThrow((_) => Exception());
      final result = await useCase();
      expect(result, isA<Failed>());
    });
  });
}
