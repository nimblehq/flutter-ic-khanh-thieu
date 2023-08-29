import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_state.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

int _pageNumber = 1;
const _pageSize = 5;
List<SurveyModel> _loadedSurveys = [];

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
        super(const HomeState.loading());

  final _surveys = StreamController<List<SurveyModel>>();
  Stream<List<SurveyModel>> get surveys => _surveys.stream;

  final _error = StreamController<String>();
  Stream<String> get error => _error.stream;

  void _handleError(Failed result) {
    var errorMessage = result.getErrorMessage();
    var isNotFoundError = result.isNotFoundError();

    if (isNotFoundError) {
      _surveys.add(_loadedSurveys);
      state = const HomeState.loadSurveysSuccess(false);
    } else {
      _error.add(errorMessage);
      state = const HomeState.error();
    }
  }

  Future<void> loadSurveys({required bool isRefreshing}) async {
    if (!isRefreshing) {
      _loadSurveysFromCache();
    }
    _loadSurveysFromRemote(isRefreshing: isRefreshing);
  }

  void _loadSurveysFromRemote({required bool isRefreshing}) async {
    if (isRefreshing) {
      _loadedSurveys.clear();
      _pageNumber = 1;
    }
    final result = await _getSurveysUseCase.call(SurveysParams(
      pageNumber: _pageNumber,
      pageSize: _pageSize,
    ));

    if (result is Success<List<SurveyModel>>) {
      final newSurveys = result.value;
      if (newSurveys.isNotEmpty) {
        _loadedSurveys.addAll(newSurveys);
        _surveys.add(_loadedSurveys);
        state = HomeState.loadSurveysSuccess(isRefreshing);
        _pageNumber++;
      }
    } else if (result is Failed) {
      _handleError(result as Failed);
    }
  }

  void _loadSurveysFromCache() async {
    final result = await _getCachedSurveysUseCase.call();
    if (result is Success<List<SurveyModel>>) {
      final cachedSurveys =
          result.value.map((survey) => survey.toSurveyModel()).toList();
      _surveys.add(cachedSurveys);
      state = const HomeState.loadCachedSurveysSuccess();
    }
  }
}
