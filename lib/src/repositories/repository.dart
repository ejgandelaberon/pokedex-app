import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/mixins/response_cache.dart';
import 'package:pokedex_app/src/providers/dio/dio_provider.dart';
import 'package:pokedex_app/src/providers/dio/response_cache.dart';

abstract class Repository with ResponseCacheMixin {
  final Ref ref;

  String get baseUrl;

  Repository(this.ref) {
    dioClient = ref.read<Dio>(dioProvider);
    dioClient.options.baseUrl = baseUrl;
    responseCache = ref.read(responseCacheProvider.notifier);
  }
}
