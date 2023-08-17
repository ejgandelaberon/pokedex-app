import 'package:pokedex_app/src/entities/pokemon/pokemon_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_service.g.dart';

@Riverpod(keepAlive: true)
class PokemonResponseCache extends _$PokemonResponseCache {
  @override
  Map<String, PokemonResponse> build() => {};

  void save(String key, PokemonResponse response) => state[key] = response;

  void clear() => state.clear();

  PokemonResponse? get(String key) => state[key];

  Map<String, PokemonResponse> get all => state;
}
