import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/surveys_container_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveysUseCase', () {
    late MockSurveyRepository mockRepository;
    late GetSurveysUseCase getSurveysUseCase;

    setUp(() {
      mockRepository = MockSurveyRepository();
      getSurveysUseCase = GetSurveysUseCase(mockRepository);
    });

    test('When getting surveys is successful returns Success ', () async {
      final surveysContainerModel = SurveysContainerModel.dummy();
      final surveysParams = SurveysParams(pageNumber: 0, pageSize: 10);
      when(mockRepository.getSurveys(pageNumber: 0, pageSize: 10))
          .thenAnswer((_) async => surveysContainerModel);

      final result = await getSurveysUseCase(surveysParams);

      expect(result, isA<Success<SurveysContainerModel>>());
    });

    test('returns Failed when getting surveys fails', () async {
      final surveysParams = SurveysParams(pageNumber: 0, pageSize: 10);

      when(mockRepository.getSurveys(pageNumber: 0, pageSize: 10))
          .thenThrow(Exception());
      final result = await getSurveysUseCase(surveysParams);

      expect(result, isA<Failed<SurveysContainerModel>>());
    });
  });
}
