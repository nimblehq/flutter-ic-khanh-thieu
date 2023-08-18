import 'package:survey_flutter/model/login_model.dart';

extension LoginModelDummy on LoginModel {
  static LoginModel instance = const LoginModel(
    id: '',
    accessToken: '',
    expiresIn: 0,
    refreshToken: '',
  );
}
