import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCachedSurveysUseCaseTest', () {
    late MockSurveyStorage mockSurveyStorage;
    late GetCachedSurveysUseCase getCachedSurveysUseCase;

    setUp(() async {
      mockSurveyStorage = MockSurveyStorage();
      getCachedSurveysUseCase = GetCachedSurveysUseCase(mockSurveyStorage);
    });

    test(
      'When fetching cached surveys returns cached surveys',
      () async {
        final surveys = <SurveyModel>[];
        final successResult = Success<List<SurveyModel>>(surveys);
        when(mockSurveyStorage.getSurveys())
            .thenAnswer((_) async => successResult.value);
        final result = await getCachedSurveysUseCase.call();
        expect(result, isA<Success<List<SurveyModel>>>());
        expect((result as Success<List<SurveyModel>>).value, surveys);
      },
    );
  });
}
