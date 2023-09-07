import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/answer_response.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'display_type')
  final String? displayType;
  @JsonKey(name: 'answers')
  final List<AnswerResponse>? answers;

  QuestionResponse({
    this.id,
    this.type,
    this.text,
    this.displayType,
    this.answers,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);
}
