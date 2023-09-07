import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'display_type')
  final String? displayType;

  AnswerResponse({
    this.id,
    this.type,
    this.text,
    this.displayOrder,
    this.displayType,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(json);
}
