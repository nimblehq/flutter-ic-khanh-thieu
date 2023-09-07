import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/question_response.dart';

part 'survey_detail_response.g.dart';

@JsonSerializable()
class SurveyDetailResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'survey_type')
  final String? surveyType;
  @JsonKey(name: 'questions')
  final List<QuestionResponse>? questions;

  SurveyDetailResponse({
    this.id,
    this.type,
    this.title,
    this.description,
    this.coverImageUrl,
    this.surveyType,
    this.questions,
  });

  factory SurveyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailResponseFromJson(json);
}
