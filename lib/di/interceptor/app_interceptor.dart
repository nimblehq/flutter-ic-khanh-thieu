import 'dart:io';

import 'package:dio/dio.dart';
import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/storage/secure_storage.dart';

const String _headerAuthorization = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthenticate;
  final Dio _dio;
  final SecureStorage? _secureStorage;

  AppInterceptor(this._requireAuthenticate, this._dio, this._secureStorage);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      final apiTokenModel =
          await _secureStorage?.getValue(key: SecureStorageKey.apiToken);
      if (apiTokenModel is ApiToken) {
        final accessToken = apiTokenModel.accessToken;
        final tokenType = apiTokenModel.tokenType;


        if (accessToken.isNotEmpty && tokenType.isNotEmpty) {
          final authorizationHeader = '$tokenType $accessToken';
          options.headers
              .putIfAbsent(_headerAuthorization, () => authorizationHeader);
        }
    }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // TODO Request new token

      // if (result is Success) {
      // TODO Update new token header
      // err.requestOptions.headers[_headerAuthorization] = newToken;

      // Create request with new access token
      final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers);
      final newRequest = await _dio.request(
          "${err.requestOptions.baseUrl}${err.requestOptions.path}",
          options: options,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters);
      handler.resolve(newRequest);
      //  } else {
      //    handler.next(err);
      //  }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(err);
      }
    }
  }
}
