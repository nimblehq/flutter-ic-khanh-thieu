import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter/model/response/login_response.dart';
import 'package:survey_flutter/storage/secure_storage.dart';

part 'api_token.g.dart';

@JsonSerializable()
class ApiToken extends SecureStorageModel {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'token_type')
  final String tokenType;

  ApiToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory ApiToken.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ApiTokenToJson(this);

  static ApiToken from(LoginResponse loginResponse) => ApiToken(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
        tokenType: loginResponse.tokenType,
      );

  @override
  bool operator ==(Object other) =>
      other is ApiToken &&
      accessToken == other.accessToken &&
      refreshToken == other.refreshToken &&
      tokenType == other.tokenType;

  @override
  int get hashCode => (accessToken + refreshToken + tokenType).hashCode;
}
