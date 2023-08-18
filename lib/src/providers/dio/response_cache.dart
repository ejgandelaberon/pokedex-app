import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'response_cache.g.dart';

@Riverpod(keepAlive: true)
class ResponseCache extends _$ResponseCache {
  @override
  Map<String, Response> build() => {};

  void save(String key, Response response) => state[key] = response;

  void clear() => state.clear();

  Response? get(String key) => state[key];

  Map<String, Response> get all => state;
}
