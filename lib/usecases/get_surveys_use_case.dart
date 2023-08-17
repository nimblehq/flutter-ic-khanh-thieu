import 'package:survey_flutter/model/surveys_container_model.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';

import 'base/base_use_case.dart';

class SurveysParams {
  final int pageNumber;
  final int pageSize;

  SurveysParams({
    required this.pageNumber,
    required this.pageSize,
  });
}

class GetSurveysUseCase extends UseCase<SurveysContainerModel, SurveysParams> {
  final SurveyRepository _repository;

  const GetSurveysUseCase(this._repository);

  @override
  Future<Result<SurveysContainerModel>> call(SurveysParams params) async {
    try {
      final result = await _repository.getSurveys(
          pageNumber: params.pageNumber, pageSize: params.pageSize);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
