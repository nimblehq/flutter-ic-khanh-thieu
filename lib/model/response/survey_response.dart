import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter/api/response_decoder.dart';
import 'package:survey_flutter/model/survey_model.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? coverImageUrl;

  SurveyResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(ResponseDecoder.decode(json));

  SurveyModel toSurveyModel() => SurveyModel(
        id: id ?? '',
        title: title ?? '',
        description: description ?? '',
        coverImageUrl: coverImageUrl ?? '',
      );
}
