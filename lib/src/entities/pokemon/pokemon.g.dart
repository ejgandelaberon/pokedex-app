// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pokemon _$$_PokemonFromJson(Map<String, dynamic> json) => _$_Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      baseExperience: json['baseExperience'] as int,
      height: json['height'] as int,
      isDefault: json['isDefault'] as bool,
      order: json['order'] as int,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$$_PokemonToJson(_$_Pokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseExperience': instance.baseExperience,
      'height': instance.height,
      'isDefault': instance.isDefault,
      'order': instance.order,
      'weight': instance.weight,
    };
