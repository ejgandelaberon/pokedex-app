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
    Response? response;

    if (!_responseCache.all.containsKey(offset.toString())) {
      log(
        'Fetching pokemons from api...',
        name: 'PokemonRepository::fetchPokemons',
      );
      response = await _get(
        'pokemon',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
        cancelToken: cancelToken,
      );

      log('Caching response...', name: 'PokemonRepository::fetchPokemons');
      _responseCache.save(offset.toString(), response);
    }

    log(
      'Fetching pokemons from cache...',
      name: 'PokemonRepository::fetchPokemons',
    );
    response = _responseCache.get(offset.toString());

    if (response == null) {
      throw Exception('Error fetching data from API');
    }

    return PokemonListResponse.fromJson(response.data);
  }

  Future<PokemonLink> fetchPokemon(
    String pokemonName, {
    CancelToken? cancelToken,
  }) async {
    Response? response;

    if (!_responseCache.all.containsKey(pokemonName)) {
      log(
        'Fetching $pokemonName from api...',
        name: 'PokemonRepository::fetchPokemon',
      );
      response = await _get(
        'pokemon/$pokemonName',
        cancelToken: cancelToken,
      );

      log('Caching $pokemonName...', name: 'PokemonRepository::fetchPokemon');
      _responseCache.save(pokemonName, response);
    }

    log(
      'Fetching $pokemonName from cache...',
      name: 'PokemonRepository::fetchPokemon',
    );
    response = _responseCache.get(pokemonName);

    if (response == null) {
      throw Exception('Error fetching data from API');
    }

    return PokemonLink.fromJson(response.data);
  }

  Future<Response> _get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await ref.read(dioProvider).get(
            "$_apiUrl/$endpoint",
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );

      log(response.toString(), name: 'PokemonRepository:_get');

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
