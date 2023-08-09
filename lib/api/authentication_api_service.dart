import 'package:dio/dio.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_api_service.g.dart';

@RestApi()
abstract class AuthenticationApiService {
  factory AuthenticationApiService(Dio dio, {String baseUrl}) = _AuthenticationApiService;

  @POST('/oauth/token')
  Future<LoginResponse> login(
    @Body() LoginRequest body,
  );
}
