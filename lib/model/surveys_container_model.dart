import 'package:equatable/equatable.dart';
import 'package:survey_flutter/model/meta_model.dart';
import 'package:survey_flutter/model/survey_model.dart';

class SurveysContainerModel extends Equatable {
  final List<SurveyModel> surveys;
  final MetaModel meta;

  const SurveysContainerModel({
    required this.surveys,
    required this.meta,
  });

  SurveysContainerModel.empty()
      : this(
          surveys: List.empty(),
          meta: const MetaModel.empty(),
        );

  @override
  List<Object?> get props => [
        surveys,
        meta,
      ];
}
