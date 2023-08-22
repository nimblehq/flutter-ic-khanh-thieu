import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/survey_api_service.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/surveys_container_model.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  return SurveyRepositoryImpl(
    SurveyApiService(DioProvider().getAuthorizedDio(
      tokenDataSource: ref.watch(tokenDataSourceProvider),
    )),
  );
});

abstract class SurveyRepository {
  Future<SurveysContainerModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyApiService _apiService;

  SurveyRepositoryImpl(this._apiService);

  @override
  Future<SurveysContainerModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final result = await _apiService.getSurveys(pageNumber, pageSize);
      return result.toSurveysContainerModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
