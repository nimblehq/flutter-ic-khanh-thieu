import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  @JsonKey(name: 'grant_type')
  final String grantType;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  RefreshTokenRequest({
    required this.grantType,
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
