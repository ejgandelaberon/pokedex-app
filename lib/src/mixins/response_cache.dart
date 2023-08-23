import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pokedex_app/src/providers/dio/response_cache.dart';

mixin ResponseCacheMixin {
  late final ResponseCache responseCache;
  late final Dio dioClient;

  String get logName => runtimeType.toString();

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required String cacheKey,
  }) async {
    try {
      Response? response;

      if (!responseCache.all.containsKey(cacheKey)) {
        log(
          'Fetching from api...',
          name: '$logName::get',
        );
        response = await dioClient.get(
          endpoint,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
        );

        log('Caching response...', name: '$logName::get');
        responseCache.save(cacheKey, response);
      }

      log('Fetching from cache...', name: '$logName::get');
      response = responseCache.get(cacheKey);

      if (response == null) {
        throw Exception('Error fetching data from API');
      }

      log('Returning response...', name: '$logName::get');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        log('API request cancelled', name: '$logName::get');
        rethrow;
      }

      throw Exception('Error fetching data from API');
    }
  }
}
