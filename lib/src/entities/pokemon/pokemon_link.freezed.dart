// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PokemonLink _$PokemonLinkFromJson(Map<String, dynamic> json) {
  return _PokemonLink.fromJson(json);
}

/// @nodoc
mixin _$PokemonLink {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PokemonLinkCopyWith<PokemonLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonLinkCopyWith<$Res> {
  factory $PokemonLinkCopyWith(
          PokemonLink value, $Res Function(PokemonLink) then) =
      _$PokemonLinkCopyWithImpl<$Res, PokemonLink>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$PokemonLinkCopyWithImpl<$Res, $Val extends PokemonLink>
    implements $PokemonLinkCopyWith<$Res> {
  _$PokemonLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PokemonLinkCopyWith<$Res>
    implements $PokemonLinkCopyWith<$Res> {
  factory _$$_PokemonLinkCopyWith(
          _$_PokemonLink value, $Res Function(_$_PokemonLink) then) =
      __$$_PokemonLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$_PokemonLinkCopyWithImpl<$Res>
    extends _$PokemonLinkCopyWithImpl<$Res, _$_PokemonLink>
    implements _$$_PokemonLinkCopyWith<$Res> {
  __$$_PokemonLinkCopyWithImpl(
      _$_PokemonLink _value, $Res Function(_$_PokemonLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_$_PokemonLink(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PokemonLink implements _PokemonLink {
  const _$_PokemonLink({required this.name, required this.url});

  factory _$_PokemonLink.fromJson(Map<String, dynamic> json) =>
      _$$_PokemonLinkFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'PokemonLink(name: $name, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PokemonLink &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PokemonLinkCopyWith<_$_PokemonLink> get copyWith =>
      __$$_PokemonLinkCopyWithImpl<_$_PokemonLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PokemonLinkToJson(
      this,
    );
  }
}

abstract class _PokemonLink implements PokemonLink {
  const factory _PokemonLink(
      {required final String name, required final String url}) = _$_PokemonLink;

  factory _PokemonLink.fromJson(Map<String, dynamic> json) =
      _$_PokemonLink.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_PokemonLinkCopyWith<_$_PokemonLink> get copyWith =>
      throw _privateConstructorUsedError;
}
