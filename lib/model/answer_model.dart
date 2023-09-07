import 'package:survey_flutter/model/response/answer_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

class AnswerModel {
  final String id;
  final String type;
  final String text;
  final int displayOrder;
  final String displayType;

  const AnswerModel({
    required this.id,
    required this.type,
    required this.text,
    required this.displayOrder,
    required this.displayType,
  });
}

extension AnswerModelExtension on AnswerResponse {
  AnswerModel toAnswerModel() => AnswerModel(
        id: id.orEmpty(),
        type: type.orEmpty(),
        text: text.orEmpty(),
        displayOrder: displayOrder ?? 0,
        displayType: displayType.orEmpty(),
      );
}
