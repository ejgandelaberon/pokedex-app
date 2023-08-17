import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ Dio Error!', name: 'Dio Provider');
    log('❌ Url: ${err.requestOptions.uri}', name: 'Dio Provider');
    log('❌ ${err.stackTrace}', name: 'Dio Provider');
    log('❌ Response Error: ${err.response?.data}', name: 'Dio Provider');
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('🌍 Sending network request: ${options.baseUrl}${options.path}', name: 'Dio Provider');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('⬅️ Received network response', name: 'Dio Provider');
    log('${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}', name: 'Dio Provider');
    log('Query params: ${response.requestOptions.queryParameters}', name: 'Dio Provider');
    log('-------------------------', name: 'Dio Provider');
    return handler.next(response);
  }
}