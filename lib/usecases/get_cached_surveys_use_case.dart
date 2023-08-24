import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/storage/survey_storage.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getCachedSurveysUseCaseProvider = Provider(
    (ref) => GetCachedSurveysUseCase(ref.watch(surveyStorageProvider)));

class GetCachedSurveysUseCase extends NoParamsUseCase<List<SurveyModel>> {
  final SurveyStorage _surveyStorage;

  GetCachedSurveysUseCase(this._surveyStorage);

  @override
  Future<Result<List<SurveyModel>>> call() async {
    final surveys = await _surveyStorage.getSurveys();
    return Success(surveys);
  }
}
