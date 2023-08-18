import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String name,
    @JsonKey(name: 'base_experience')
    required int baseExperience,
    required int height,
    @JsonKey(name: 'is_default')
    required bool isDefault,
    required int order,
    required int weight,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, Object?> json) =>
      _$PokemonFromJson(json);
}
