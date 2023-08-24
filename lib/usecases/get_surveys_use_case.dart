import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

class SurveysParams {
  final int pageNumber;
  final int pageSize;

  SurveysParams({
    required this.pageNumber,
    required this.pageSize,
  });
}

final getSurveysUseCaseProvider =
    Provider((ref) => GetSurveysUseCase(ref.watch(surveyRepositoryProvider)));

class GetSurveysUseCase extends UseCase<List<SurveyModel>, SurveysParams> {
  final SurveyRepository _repository;

  const GetSurveysUseCase(this._repository);

  @override
  Future<Result<List<SurveyModel>>> call(SurveysParams params) async {
    try {
      final result = await _repository.getSurveys(
          pageNumber: params.pageNumber, pageSize: params.pageSize);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
