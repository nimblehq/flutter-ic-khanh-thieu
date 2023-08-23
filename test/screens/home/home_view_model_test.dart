import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_state.dart';
import 'package:survey_flutter/screens/home/home_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart'; // Import your generated mocks

void main() {
  group('HomeViewModel', () {
    late MockGetCachedSurveysUseCase mockGetCachedSurveysUseCase;
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late HomeViewModel homeViewModel;
    late ProviderContainer providerContainer;

    final List<SurveyModel> surveys = <SurveyModel>[
      const SurveyModel.dummy(),
      const SurveyModel.dummy(),
    ];

    final UseCaseException exception =
        UseCaseException(const NetworkExceptions.unauthorisedRequest());

    setUp(() {
      mockGetCachedSurveysUseCase = MockGetCachedSurveysUseCase();
      mockGetSurveysUseCase = MockGetSurveysUseCase();

      providerContainer = ProviderContainer(
        overrides: [
          getCachedSurveysUseCaseProvider
              .overrideWithValue(mockGetCachedSurveysUseCase),
          getSurveysUseCaseProvider.overrideWithValue(mockGetSurveysUseCase),
        ],
      );
      homeViewModel = providerContainer.read(homeViewModelProvider.notifier);
    });

    test(
      'loads surveys successfully and emits LoadSurveysSuccess state',
      () async {
        when(mockGetSurveysUseCase.call(any)).thenAnswer(
          (_) async => Success(surveys),
        );
        final surveysStream = homeViewModel.surveys;
        homeViewModel.loadSurveys();
        expect(surveysStream, emitsInOrder([surveys]));
      },
    );

    test(
      'loads cached surveys successfully and emits LoadCachedSurveysSuccess state',
      () async {
        when(mockGetCachedSurveysUseCase.call())
            .thenAnswer((_) => Future.value(Success(surveys)));
        final surveysStream = homeViewModel.surveys;
        final stateStream = homeViewModel.stream;
        homeViewModel.loadCachedSurveys();
        expect(surveysStream, emitsInOrder([surveys]));
        expect(stateStream,
            emitsInOrder([const HomeState.loadCachedSurveysSuccess()]));
      },
    );

    test(
      'loads surveys with error and emits error state',
      () async {
        when(mockGetSurveysUseCase.call(any)).thenAnswer(
          (_) async => Failed(exception),
        );
        final errorStream = homeViewModel.error;
        homeViewModel.loadSurveys();
        expect(
          errorStream,
          emitsInOrder(
            [NetworkExceptions.getErrorMessage(exception.actualException)],
          ),
        );
      },
    );

    tearDown(() {
      providerContainer.dispose();
    });
  });
}
