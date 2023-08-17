import 'package:injectable/injectable.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/survey_api_service.dart';
import 'package:survey_flutter/model/surveys_container_model.dart';

abstract class SurveyRepository {
  Future<SurveysContainerModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

@LazySingleton(as: SurveyRepository)
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
