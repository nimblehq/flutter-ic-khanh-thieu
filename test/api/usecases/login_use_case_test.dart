import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/login_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthenticationRepository mockAuthRepository;
    late LoginUseCase useCase;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthenticationRepository();
      useCase = LoginUseCase(mockAuthRepository);
    });

    test('When login success, it returns success model', () async {
      const loginModel = LoginModel(
        id: "",
        accessToken: "",
        expiresIn: 0,
        refreshToken: "",
      );
      when(mockAuthRepository.login(
        email: email,
        password: password,
      )).thenAnswer((_) async => loginModel);

      final result = await useCase.call(LoginParams(
        email: email,
        password: password,
      ));

      verify(mockAuthRepository.login(
        email: email,
        password: password,
      ));
      expect(result, isA<Success<LoginModel>>());
    });

    test('When login fail, it returns failure with exception', () async {
      when(mockAuthRepository.login(
        email: email,
        password: password,
      )).thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(LoginParams(
        email: email,
        password: password,
      ));

      verify(mockAuthRepository.login(
        email: email,
        password: password,
      ));

      expect(result, isA<Failed<LoginModel>>());
    });
  });
}
