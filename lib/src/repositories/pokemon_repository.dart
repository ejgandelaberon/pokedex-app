import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_link.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_list_response.dart';
import 'package:pokedex_app/src/providers/dio/dio_provider.dart';
import 'package:pokedex_app/src/providers/dio/response_cache.dart';

final pokemonRepositoryProvider = Provider(PokemonRepository.new);

class PokemonRepository {
  PokemonRepository(this.ref)
      : _responseCache = ref.read(responseCacheProvider.notifier);

  static const _apiUrl = 'https://pokeapi.co/api/v2';

  final Ref ref;
  final ResponseCache _responseCache;

  Future<PokemonListResponse> fetchPokemons({
    required int offset,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    final response = await _get(
      'pokemon',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
      cancelToken: cancelToken,
      cacheKey: offset.toString(),
    );

    return PokemonListResponse.fromJson(response.data);
  }

  Future<PokemonLink> fetchPokemon(
    String pokemonName, {
    CancelToken? cancelToken,
  }) async {
    final response = await _get(
      'pokemon/$pokemonName',
      cancelToken: cancelToken,
      cacheKey: pokemonName,
    );

    return PokemonLink.fromJson(response.data);
  }

  Future<Response> _get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required String cacheKey,
  }) async {
    try {
      Response? response;

      if (!_responseCache.all.containsKey(cacheKey)) {
        log(
          'Fetching from api...',
          name: 'PokemonRepository::_get',
        );
        response = await ref.read(dioProvider).get(
              "$_apiUrl/$endpoint",
              queryParameters: queryParameters,
              cancelToken: cancelToken,
            );

        log('Caching response...', name: 'PokemonRepository::_get');
        _responseCache.save(cacheKey, response);
      }

      log('Fetching from cache...', name: 'PokemonRepository::_get');
      response = _responseCache.get(cacheKey);

      if (response == null) {
        throw Exception('Error fetching data from API');
      }

      log('Returning response...', name: 'PokemonRepository:_get');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        log('API request cancelled', name: 'PokemonRepository:_get');
        rethrow;
      }

      throw Exception('Error fetching data from API');
    }
  }
}
