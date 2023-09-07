import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/surveys_container_response.dart';

part 'survey_api_service.g.dart';

@RestApi()
abstract class SurveyApiService {
  factory SurveyApiService(Dio dio, {String baseUrl}) = _SurveyApiService;

  @GET('/surveys')
  Future<SurveysContainerResponse> getSurveys(
    @Query('page[number]') int pageNumber,
    @Query('page[size]') int pageSize,
  );

  @GET('/surveys/{surveyId}')
  Future<SurveyDetailDataResponse> getSurveyDetail(
    @Path('surveyId') String surveyId,
  );
}
