import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/screens/splash/splash_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/check_user_logged_in_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SplashViewModel', () {
    late ProviderContainer container;
    late MockCheckUserLoggedInUseCase mockCheckUserLoggedInUseCase;

    setUp(() {
      mockCheckUserLoggedInUseCase = MockCheckUserLoggedInUseCase();
      container = ProviderContainer(
        overrides: [
          checkUserLoggedInUseCaseProvider
              .overrideWithValue(mockCheckUserLoggedInUseCase),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When hasUserLoggedInUseCase returns success, it returns true',
        () async {
      when(mockCheckUserLoggedInUseCase())
          .thenAnswer((_) async => Success(true));

      // The first read if the loading state
      expect(
        container.read(splashViewModelProvider),
        const AsyncValue<bool>.loading(),
      );

      /// Wait for the request to finish
      await container.read(splashViewModelProvider.future);

      // Exposes the data
      expect(
        container.read(splashViewModelProvider).value,
        isA<bool>().having((result) => result, '', true),
      );
    });

    test('When hasUserLoggedInUseCase returns failed, it returns false',
        () async {
      when(mockCheckUserLoggedInUseCase())
          .thenAnswer((_) async => Failed(UseCaseException(Exception())));

      // The first read if the loading state
      expect(
        container.read(splashViewModelProvider),
        const AsyncValue<bool>.loading(),
      );

      /// Wait for the request to finish
      await container.read(splashViewModelProvider.future);

      // Exposes the data
      expect(
        container.read(splashViewModelProvider).value,
        isA<bool>().having((result) => result, '', false),
      );
    });
  });
}
