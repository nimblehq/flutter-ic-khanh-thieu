import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:survey_flutter/di/interceptor/app_interceptor.dart';
import 'package:survey_flutter/env.dart';

const String _headerContentType = 'Content-Type';
const String _defaultContentType = 'application/json; charset=utf-8';

class DioProvider {
  Dio? _dio;

  Dio getDio() {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(
      requireAuthenticate,
      dio,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
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
