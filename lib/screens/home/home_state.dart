import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _Init;

  const factory HomeState.loading() = _Loading;

  const factory HomeState.loadCachedSurveysSuccess() =
      _LoadCachedSurveysSuccess;

  const factory HomeState.loadSurveysSuccess() = _LoadSurveysSuccess;

  const factory HomeState.error() = _error;
}
