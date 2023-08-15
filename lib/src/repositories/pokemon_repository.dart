import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_link.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_list_response.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_response.dart';
import 'package:pokedex_app/src/providers/dio/dio_provider.dart';

final pokemonRepositoryProvider = Provider(PokemonRepository.new);

class PokemonRepository {
  PokemonRepository(this.ref);

  static const _apiUrl = 'https://pokeapi.co/api/v2';

  final Ref ref;
  final _pokemonCache = <String, PokemonLink>{};

  Future<PokemonListResponse> fetchPokemons({
    required int offset,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    final response = await get(
      'pokemon',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
      cancelToken: cancelToken,
    );

    final result = PokemonListResponse(
      results:
          response.data.results.map((e) => PokemonLink.fromJson(e)).toList(),
      count: response.data.count,
      next: response.data.next,
      previous: response.data.previous,
    );

    for (final pokemonLink in result.results) {
      _pokemonCache[pokemonLink.name] = pokemonLink;
    }

    return result;
  }

  Future<PokemonLink> fetchPokemon(
    String pokemonName, {
    CancelToken? cancelToken,
  }) async {
    if (_pokemonCache.containsKey(pokemonName)) {
      return _pokemonCache[pokemonName]!;
    }

    try {
      final response = await get(
        pokemonName,
        cancelToken: cancelToken,
      );

      return PokemonLink.fromJson(response.data.results.single);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        log(
          'API request cancelled',
          name: 'PokemonRepository:fetchPokemon',
        );
        rethrow;
      }

      throw Exception('Error fetching data from API');
    }
  }

  Future<PokemonResponse> get(
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

      final pokemonResponse = PokemonResponse.fromJson({
        'data': response.data,
      });

      log(pokemonResponse.toString(), name: 'PokemonRepository:get');

      return pokemonResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        log('API request cancelled', name: 'PokemonRepository:get');
        rethrow;
      }

      throw Exception('Error fetching data from API');
    }
  }
}
