import 'package:survey_flutter/model/survey_detail_model.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

class GetSurveyDetailUseCase extends UseCase<SurveyDetailModel, String> {
  final SurveyRepository _surveyRepository;

  GetSurveyDetailUseCase(this._surveyRepository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Result<SurveyDetailModel>> call(String surveyId) async {
    try {
      final result = await _surveyRepository.getSurveyDetail(surveyId);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
