import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/utils/async_listener.dart';

@GenerateMocks([
  AsyncListener,
  AuthenticationApiService,
  AuthenticationRepository,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
