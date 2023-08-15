import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';

import '../utils/async_listener.dart';

@GenerateMocks([
  AsyncListener,
  AuthenticationApiService,
  AuthenticationRepository,
  DioError,
  InternetConnectionManager,
])
main() {
  // empty class to generate mock repository classes
}
