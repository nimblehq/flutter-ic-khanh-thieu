import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';

void main() {
  group('LoginViewModel', () {
    late ProviderContainer container;
    late LoginViewModel loginViewModel;

    setUp(() {
      container = ProviderContainer();
      loginViewModel = container.read(loginViewModelProvider.notifier);
    });

    tearDown(() => container.dispose());

    group('email validation', () {
      test('When validating a null email, it returns false', () {
        expect(loginViewModel.isValidEmail(null), false);
      });

      test('When validating an empty email, it returns false', () {
        const email = '';
        expect(loginViewModel.isValidEmail(email), false);
      });

      test('When validating an invalid email, it returns false', () {
        const email = 'user.test.com';
        expect(loginViewModel.isValidEmail(email), false);
      });

      test('When validating a valid email, it returns true', () {
        const email = 'user@test.com';
        expect(loginViewModel.isValidEmail(email), true);
      });
    });

    group('password validation', () {
      test('When validating a null password, it returns false', () {
        expect(loginViewModel.isValidPassword(null), false);
      });

      test('When validating an empty password, it returns false', () {
        const password = '';
        expect(loginViewModel.isValidPassword(password), false);
      });

      test(
          'When validating a password that having less than 8 letters, it returns false',
          () {
        const password = '1234567';
        expect(loginViewModel.isValidPassword(password), false);
      });

      test('When validating a password that having 8 letters, it returns true',
          () {
        const password = '12345678';
        expect(loginViewModel.isValidPassword(password), true);
      });

      test(
          'When validating a password that having more than 8 letters, it returns true',
          () {
        const password = '1234567890';
        expect(loginViewModel.isValidPassword(password), true);
      });
    });
  });
}
