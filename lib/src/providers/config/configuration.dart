// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_app/src/extensions/string_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'configuration.freezed.dart';

part 'configuration.g.dart';

@freezed
class Configuration with _$Configuration {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Configuration({required String apiUrl}) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}

@riverpod
Future<Configuration> configurations(ConfigurationsRef ref) async {
  final content = json.decode(
    await rootBundle.loadString('assets/config.json'),
  ) as Map<String, dynamic>;

  for (var key in content.keys) {
    assert(
      key.isSnakeCase(),
      'The key "$key" in config.json is not in snake_case.',
    );
  }

  return Configuration.fromJson(content);
}
