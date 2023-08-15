// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Configuration _$$_ConfigurationFromJson(Map<String, dynamic> json) =>
    _$_Configuration(
      apiUrl: json['api_url'] as String,
    );

Map<String, dynamic> _$$_ConfigurationToJson(_$_Configuration instance) =>
    <String, dynamic>{
      'api_url': instance.apiUrl,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configurationsHash() => r'760f88ad6cb996c51468df978c86858f34d9d24f';

/// See also [configurations].
@ProviderFor(configurations)
final configurationsProvider =
    AutoDisposeFutureProvider<Configuration>.internal(
  configurations,
  name: r'configurationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configurationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigurationsRef = AutoDisposeFutureProviderRef<Configuration>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
