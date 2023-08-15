import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_data.freezed.dart';

part 'pokemon_data.g.dart';

@freezed
class PokemonData with _$PokemonData {
  const factory PokemonData({
    required List<Map<String, dynamic>> results,
    required int count,
    String? next,
    String? previous,
  }) = _PokemonData;

  factory PokemonData.fromJson(Map<String, dynamic> json) =>
      _$PokemonDataFromJson(json);
}
