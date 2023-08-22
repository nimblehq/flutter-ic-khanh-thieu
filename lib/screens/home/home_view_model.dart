import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_state.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

const _pageNumber = 1;
const _pageSize = 10;

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  final getSurveysUseCase = ref.read(getSurveysUseCaseProvider);
  final getCachedSurveysUseCase = ref.read(getCachedSurveysUseCaseProvider);

  return HomeViewModel(
    getSurveysUseCase: getSurveysUseCase,
    getCachedSurveysUseCase: getCachedSurveysUseCase,
  );
});

class HomeViewModel extends StateNotifier<HomeState> {
  final GetCachedSurveysUseCase _getCachedSurveysUseCase;
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel({
    required GetSurveysUseCase getSurveysUseCase,
    required GetCachedSurveysUseCase getCachedSurveysUseCase,
  })  : _getSurveysUseCase = getSurveysUseCase,
        _getCachedSurveysUseCase = getCachedSurveysUseCase,
        super(const HomeState.init());

  final _surveys = StreamController<List<SurveyModel>>();
  Stream<List<SurveyModel>> get surveys => _surveys.stream;

  final _error = StreamController<String>();
  Stream<String> get error => _error.stream;

  void loadSurveys() async {
    final result = await _getSurveysUseCase.call(SurveysParams(
      pageNumber: _pageNumber,
      pageSize: _pageSize,
    ));
    if (result is Success<List<SurveyModel>>) {
      final newSurveys = result.value;
      _surveys.add(newSurveys);
      state = const HomeState.loadSurveysSuccess();
    } else if (result is Failed) {
      _error.add((result as Failed).getErrorMessage());
      state = const HomeState.error();
    }
  }

  void loadCachedSurveys() async {    
    final result = await _getCachedSurveysUseCase.call();
    if (result is Success<List<SurveyModel>>) {
      final cachedSurveys =
          result.value.map((survey) => survey.toSurveyModel()).toList();
      _surveys.add(cachedSurveys);
      state = const HomeState.loadCachedSurveysSuccess();
    }
  }
}
