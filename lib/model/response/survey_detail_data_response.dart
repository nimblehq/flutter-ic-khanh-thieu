import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';

part 'survey_detail_data_response.g.dart';

@JsonSerializable()
class SurveyDetailDataResponse {
  @JsonKey(name: 'data')
  final SurveyDetailResponse? surveyDetailResponse;

  SurveyDetailDataResponse(this.surveyDetailResponse);

  factory SurveyDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailDataResponseFromJson(json);
}
