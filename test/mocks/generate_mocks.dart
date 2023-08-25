import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/authentication_api_service.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/api/survey_api_service.dart';
import 'package:survey_flutter/repositories/authentication_repository.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';
import 'package:survey_flutter/storage/secure_storage.dart';
import 'package:survey_flutter/storage/survey_storage.dart';
import 'package:survey_flutter/usecases/check_user_logged_in_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';
import 'package:survey_flutter/utils/internet_connection_manager.dart';

import '../utils/async_listener.dart';

@GenerateMocks([
  AsyncListener,
  AuthenticationApiService,
  AuthenticationRepository,
  CheckUserLoggedInUseCase,
  DioError,
  GetCachedSurveysUseCase,
  GetSurveysUseCase,
  InternetConnectionManager,
  LoginUseCase,
  SecureStorage,
  SurveyApiService,
  SurveyStorage,
  SurveyRepository,
  TokenDataSource,
])
main() {
  // empty class to generate mock repository classes
}
