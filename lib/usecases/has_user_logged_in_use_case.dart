import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

class HasUserLoggedInUseCase implements NoParamsUseCase<bool> {
  final TokenDataSource _tokenDataSource;

  HasUserLoggedInUseCase(this._tokenDataSource);
  @override
  Future<Result<bool>> call() async {
    try {
      final _ = await _tokenDataSource.getToken();
      return Success(true);
    } catch (error) {
      return Failed(UseCaseException(error));
    }
  }
}
