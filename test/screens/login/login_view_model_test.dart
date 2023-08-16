import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';

import '../../mocks/dummy_models.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginViewModel', () {
    late ProviderContainer container;
    late MockInternetConnectionManager mockInternetConnectionManager;
    late MockLoginUseCase mockLoginUseCase;
    late MockAsyncListener listener;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockInternetConnectionManager = MockInternetConnectionManager();

      container = ProviderContainer(
        overrides: [
          loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
          internetConnectionManagerProvider
              .overrideWithValue(mockInternetConnectionManager),
        ],
      );

      listener = MockAsyncListener();
      container.listen(
        loginViewModelProvider,
        listener,
        fireImmediately: true,
      );
    });

    tearDown(() => container.dispose());

    group('email validation', () {
      test('When validating a null email, it returns false', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidEmail(null), false);
      });

      test('When validating an empty email, it returns false', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidEmail(''), false);
      });

      test('When validating an invalid email, it returns false', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidEmail('user.test.com'), false);
      });

      test('When validating a valid email, it returns true', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidEmail('user@test.com'), true);
      });
    });

    group('password validation', () {
      test('When validating a null password, it returns false', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidPassword(null), false);
      });

      test('When validating an empty password, it returns false', () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidPassword(''), false);
      });

      test(
          'When validating a password that having less than 8 letters, it returns false',
          () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidPassword('1234567'), false);
      });

      test('When validating a password that having 8 letters, it returns true',
          () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidPassword('12345678'), true);
      });

      test(
          'When validating a password that having more than 8 letters, it returns true',
          () {
        final loginViewModel = container.read(loginViewModelProvider.notifier);
        expect(loginViewModel.isValidPassword('1234567890'), true);
      });
    });

    group('login', () {
      test(
          'When logging in with a bad request, it emits loading and error correspondingly',
          () async {
        final exception =
            UseCaseException(const NetworkExceptions.badRequest());
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => Failed(exception));
        when(mockInternetConnectionManager.hasConnection())
            .thenAnswer((_) async => true);

        const data = AsyncData<void>(null);
        // verify initial value from build method
        verify(listener(null, data));

        final loginViewModel = container.read(loginViewModelProvider.notifier);
        await loginViewModel.login(
            email: 'user@test.com', password: '12345678');

        verifyInOrder([
          listener(data, isA<AsyncLoading>()),
          listener(isA<AsyncLoading<void>>(), isA<AsyncError<void>>()),
        ]);
        verifyNoMoreInteractions(listener);
      });

      test(
          'When logging in with a unauthorized request, it emits loading and error correspondingly',
          () async {
        final exception =
            UseCaseException(const NetworkExceptions.unauthorisedRequest());
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => Failed(exception));
        when(mockInternetConnectionManager.hasConnection())
            .thenAnswer((_) async => true);

        const data = AsyncData<void>(null);
        // verify initial value from build method
        verify(listener(null, data));

        final loginViewModel = container.read(loginViewModelProvider.notifier);
        await loginViewModel.login(
            email: 'user@test.com', password: '12345678');

        verifyInOrder([
          listener(data, isA<AsyncLoading>()),
          listener(isA<AsyncLoading<void>>(), isA<AsyncError<void>>()),
        ]);
        verifyNoMoreInteractions(listener);
      });

      test(
          'When logging in timeout with Internet connection, it emits loading and error correspondingly',
          () async {
        final exception =
            UseCaseException(const NetworkExceptions.requestTimeout());
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => Failed(exception));
        when(mockInternetConnectionManager.hasConnection())
            .thenAnswer((_) async => true);

        const data = AsyncData<void>(null);
        // verify initial value from build method
        verify(listener(null, data));

        final loginViewModel = container.read(loginViewModelProvider.notifier);
        await loginViewModel.login(
            email: 'user@test.com', password: '12345678');

        verifyInOrder([
          listener(data, isA<AsyncLoading>()),
          listener(isA<AsyncLoading<void>>(), isA<AsyncError<void>>()),
        ]);
        verifyNoMoreInteractions(listener);
      });

      test(
          'When logging in timeout without Internet connection, it emits loading and error correspondingly',
          () async {
        final exception =
            UseCaseException(const NetworkExceptions.requestTimeout());
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => Failed(exception));
        when(mockInternetConnectionManager.hasConnection())
            .thenAnswer((_) async => false);

        const data = AsyncData<void>(null);
        // verify initial value from build method
        verify(listener(null, data));

        final loginViewModel = container.read(loginViewModelProvider.notifier);
        await loginViewModel.login(
            email: 'user@test.com', password: '12345678');

        verifyInOrder([
          listener(data, isA<AsyncLoading>()),
          listener(isA<AsyncLoading<void>>(), isA<AsyncError<void>>()),
        ]);
        verifyNoMoreInteractions(listener);
      });

      test(
          'When logging in successfully, it emits loading and data correspondingly',
          () async {
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => Success(LoginModelDummy.instance));

        const data = AsyncData<void>(null);
        // verify initial value from build method
        verify(listener(null, data));

        final loginViewModel = container.read(loginViewModelProvider.notifier);
        await loginViewModel.login(
            email: 'user@test.com', password: '12345678');

        verifyInOrder([
          listener(data, isA<AsyncLoading>()),
          listener(isA<AsyncLoading<void>>(), data),
        ]);
        verifyNoMoreInteractions(listener);
      });
    });
  });
}
