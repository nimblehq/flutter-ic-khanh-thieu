import 'dart:io';

import 'package:dio/dio.dart';
import 'package:survey_flutter/api/data_sources/token_data_source.dart';

const String _headerAuthorization = 'Authorization';
const String _retryCountOption = 'Retry-Count';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenDataSource _tokenDataSource;

  AuthInterceptor(
    this._dio,
    this._tokenDataSource,
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenDataSource.getToken();
    options.headers.putIfAbsent(
        _headerAuthorization, () => "${token.tokenType} ${token.accessToken}");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    if (statusCode != HttpStatus.forbidden &&
        statusCode != HttpStatus.unauthorized &&
        requestOptions.extra[_retryCountOption] != 1) {
      handler.next(err);
      return;
    }

    requestOptions.extra[_retryCountOption] = 1;
    _refreshTokenAndRetry(requestOptions, handler);
  }

  Future<void> _refreshTokenAndRetry(
      RequestOptions options, ErrorInterceptorHandler handler) async {
    final token = await _tokenDataSource.getToken(forceRefresh: true);
    final headers = options.headers;
    headers[_headerAuthorization] = "${token.tokenType} ${token.accessToken}";
    final newOptions = options.copyWith(headers: headers);
    await _dio.fetch(newOptions).then((response) => handler.resolve(response));
  }
}
