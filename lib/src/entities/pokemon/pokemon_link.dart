import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_link.freezed.dart';
part 'pokemon_link.g.dart';

@freezed
class PokemonLink with _$PokemonLink {
  const factory PokemonLink({
    required String name,
    required String url,
  }) = _PokemonLink;

  factory PokemonLink.fromJson(Map<String, dynamic> json) =>
      _$PokemonLinkFromJson(json);
}
