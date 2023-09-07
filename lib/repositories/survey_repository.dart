import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/survey_api_service.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/survey_detail_model.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/storage/survey_storage.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  final surveyStorage = ref.watch(surveyStorageProvider);
  return SurveyRepositoryImpl(
    SurveyApiService(DioProvider().getAuthorizedDio(
      tokenDataSource: ref.watch(tokenDataSourceProvider),
    )),
    surveyStorage,
  );
});

abstract class SurveyRepository {
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  });

  Future<SurveyDetailModel> getSurveyDetail(String surveyid);
}

class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyApiService _apiService;
  final SurveyStorage _surveyStorage;

  SurveyRepositoryImpl(this._apiService, this._surveyStorage);

  @override
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await _apiService.getSurveys(pageNumber, pageSize);
      final surveys = response.data ?? [];
      final surveyModels =
          surveys.map((item) => (item.toSurveyModel())).toList();
      _surveyStorage.saveSurveys(surveyModels);
      return surveyModels;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyDetailModel> getSurveyDetail(String surveyid) async {
    try {
      final response = await _apiService.getSurveyDetail(surveyid);
      final surveyDetailResponse = response.surveyDetailResponse;
      if (surveyDetailResponse == null) {
        // TODO: Update catching
        throw const NetworkExceptions.unexpectedError();
      }
      return surveyDetailResponse.toSurveyDetailModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
