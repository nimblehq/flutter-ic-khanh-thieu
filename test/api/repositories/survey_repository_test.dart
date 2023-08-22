import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/response/meta_response.dart';
import 'package:survey_flutter/model/response/surveys_container_response.dart';
import 'package:survey_flutter/repositories/survey_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SurveyRepository', () {
    late MockSurveyApiService mockSurveyApiService;
    late MockSurveyStorage mockSurveyStorage;
    late SurveyRepositoryImpl surveyRepository;

    setUp(() {
      mockSurveyApiService = MockSurveyApiService();
      mockSurveyStorage = MockSurveyStorage();
      surveyRepository = SurveyRepositoryImpl(
          mockSurveyApiService, mockSurveyStorage);
    });

    test('when getting surveys is successful returns SurveysContainerModel',
        () async {
      final surveysResponse = SurveysContainerResponse(
        data: List.empty(),
        meta: MetaResponse.dummy(),
      );
      when(mockSurveyApiService.getSurveys(any, any))
          .thenAnswer((_) async => surveysResponse);

      final result =
          await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);
      expect(result, surveysResponse.toSurveysContainerModel().surveys);
    });

    test('when getting surveys fails throws NetworkExceptions', () async {
      when(mockSurveyApiService.getSurveys(any, any)).thenThrow(Exception());

      expect(
        () async =>
            await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0),
        throwsA(isInstanceOf<NetworkExceptions>()),
      );
    });
  });
}
