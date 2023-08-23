import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_list_response.dart';
import 'package:pokedex_app/src/repositories/repository.dart';

final pokemonRepositoryProvider = Provider(PokemonRepository.new);

class PokemonRepository extends Repository {
  PokemonRepository(Ref ref) : super(ref);

  @override
  String get baseUrl => 'https://pokeapi.co/api/v2/';

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
      cacheKey: offset.toString(),
    );

    return PokemonListResponse.fromJson(response.data);
  }

  Future<Pokemon> fetchPokemon(
    String pokemonName, {
    CancelToken? cancelToken,
  }) async {
    final response = await get(
      'pokemon/$pokemonName',
      cancelToken: cancelToken,
      cacheKey: pokemonName,
    );

    return Pokemon.fromJson(response.data);
  }
}
