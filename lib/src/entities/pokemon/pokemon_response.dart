import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_data.dart';

part 'pokemon_response.freezed.dart';

part 'pokemon_response.g.dart';

@freezed
class PokemonResponse with _$PokemonResponse {
  const factory PokemonResponse(PokemonData data) = _PokemonResponse;

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonResponseFromJson(json);
}
