import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';
import 'package:survey_flutter/api/interceptor/auth_interceptor.dart';
import 'package:survey_flutter/env.dart';

const String _headerContentType = 'Content-Type';
const String _defaultContentType = 'application/json; charset=utf-8';

class DioProvider {
  Dio? _dio;
  Dio? _authorizedDio;
  TokenDataSource? _tokenDataSource;

  Dio getDio() {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio getAuthorizedDio({
    required TokenDataSource tokenDataSource,
  }) {
    _tokenDataSource = tokenDataSource;
    _authorizedDio ??= _createDio(requireAuthentication: true);
    return _authorizedDio!;
  }

  Dio _createDio({bool requireAuthentication = false}) {
    final dio = Dio();

    final interceptors = <Interceptor>[];
    if (requireAuthentication) {
      final authInterceptor = AuthInterceptor(
        dio,
        _tokenDataSource!,
      );
      interceptors.add(authInterceptor);
    }
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = const Duration(seconds: 3)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.headers = {_headerContentType: _defaultContentType}
      ..interceptors.addAll(interceptors)
      ..options.baseUrl = Env.restApiEndpoint;
  }
}
