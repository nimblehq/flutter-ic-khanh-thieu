import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter/api/response_decoder.dart';
import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/model/login_model.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String id;
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
  final int createdAt;

  TokenResponse({
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(ResponseDecoder.decodeData(json));

  LoginModel toLoginModel() => LoginModel(
        id: id,
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
      );

  ApiToken toApiToken() => ApiToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
        tokenType: tokenType,
      );

  static TokenResponse dummy() {
    return TokenResponse(
      id: "",
      accessToken: "",
      tokenType: "",
      expiresIn: 0,
      refreshToken: "",
      createdAt: 0,
    );
  }
}
