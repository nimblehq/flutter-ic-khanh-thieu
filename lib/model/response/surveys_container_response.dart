import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/response_decoder.dart';
import 'package:survey_flutter/model/meta_model.dart';
import 'package:survey_flutter/model/response/meta_response.dart';
import 'package:survey_flutter/model/response/survey_reponse.dart';
import 'package:survey_flutter/model/surveys_container_model.dart';

part 'surveys_container_response.g.dart';

@JsonSerializable()
class SurveysContainerResponse {
  final List<SurveyResponse>? data;
  final MetaResponse? meta;

  const SurveysContainerResponse({
    required this.data,
    required this.meta,
  });

  factory SurveysContainerResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveysContainerResponseFromJson(
        ResponseDecoder.decodeAtRoot(json));
  }

  SurveysContainerModel toSurveysContainerModel() => SurveysContainerModel(
        surveys:
            data?.map((item) => item.toSurveyModel()).toList() ?? List.empty(),
        meta: meta?.toMetaModel() ?? const MetaModel.empty(),
      );
}
