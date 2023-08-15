import 'package:pokedex_app/src/entities/pokemon/pokemon_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_service.g.dart';

@Riverpod(keepAlive: true)
class PokemonCache extends _$PokemonCache {
  @override
  Map<String, PokemonListResponse> build() => {};

  void save(String key, PokemonListResponse response) => state[key] = response;

  void clear() => state.clear();

  PokemonListResponse? get(String key) => state[key];

  Map<String, PokemonListResponse> get all => state;
}