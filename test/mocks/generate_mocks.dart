import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/survey_api_service.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/storage/secure_storage.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';

import '../utils/async_listener.dart';

@GenerateMocks([
  AsyncListener,
  AuthenticationApiService,
  AuthenticationRepository,
  DioError,
  InternetConnectionManager,
  LoginUseCase,
  SecureStorage,
  SurveyRepository,
  SurveyApiService,
])
main() {
  // empty class to generate mock repository classes
}
