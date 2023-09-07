import 'package:survey_flutter/model/question_model.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

class SurveyDetailModel {
  final String id;
  final String type;
  final String title;
  final String description;
  final String coverImageUrl;
  final String surveyType;
  final List<QuestionModel> questions;

  const SurveyDetailModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.surveyType,
    required this.questions,
  });
}

extension SurveyDetailModelExtension on SurveyDetailResponse {
  SurveyDetailModel toSurveyDetailModel() => SurveyDetailModel(
        id: id.orEmpty(),
        type: type.orEmpty(),
        title: type.orEmpty(),
        description: description.orEmpty(),
        coverImageUrl: coverImageUrl.orEmpty(),
        surveyType: surveyType.orEmpty(),
        questions:
            questions?.map((question) => question.toQuestionModel()).toList() ??
                [],
      );
}
