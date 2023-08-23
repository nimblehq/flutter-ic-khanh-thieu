import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/request/refresh_token_request.dart';
import 'package:survey_flutter/model/response/token_response.dart';

part 'authentication_api_service.g.dart';

@RestApi()
abstract class AuthenticationApiService {
  factory AuthenticationApiService(Dio dio, {String baseUrl}) =
      _AuthenticationApiService;

  @POST('/oauth/token')
  Future<TokenResponse> login(
    @Body() LoginRequest loginRequest,
  );

  @POST('/oauth/token')
  Future<TokenResponse> refreshToken(
    @Body() RefreshTokenRequest refreshTokenRequest,
  );
}
