import 'package:survey_flutter/model/answer_model.dart';
import 'package:survey_flutter/model/response/question_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

class QuestionModel {
  final String id;
  final String type;
  final String text;
  final String displayType;
  final List<AnswerModel> answers;

  QuestionModel({
    required this.id,
    required this.type,
    required this.text,
    required this.displayType,
    required this.answers,
  });
}

extension QuestionModelExtension on QuestionResponse {
  QuestionModel toQuestionModel() => QuestionModel(
        id: id.orEmpty(),
        type: type.orEmpty(),
        text: text.orEmpty(),
        displayType: displayType.orEmpty(),
        answers:
            answers?.map((answer) => answer.toAnswerModel()).toList() ?? [],
      );
}
