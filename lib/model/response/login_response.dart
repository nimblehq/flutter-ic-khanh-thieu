import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter/api/response_decoder.dart';
import 'package:survey_flutter/model/login_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String id;
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
  final int createdAt;

  LoginResponse({
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(decode(json));

  LoginModel toLoginModel() => LoginModel(
        id: id,
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
      );
}
