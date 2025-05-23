// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'office_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OfficeEntity _$OfficeEntityFromJson(Map<String, dynamic> json) {
  return _OfficeEntity.fromJson(json);
}

/// @nodoc
mixin _$OfficeEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  int? get radius => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficeEntityCopyWith<OfficeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeEntityCopyWith<$Res> {
  factory $OfficeEntityCopyWith(
          OfficeEntity value, $Res Function(OfficeEntity) then) =
      _$OfficeEntityCopyWithImpl<$Res, OfficeEntity>;
  @useResult
  $Res call(
      {int? id,
      String? nama,
      String? address,
      String? latitude,
      String? longitude,
      int? radius});
}

/// @nodoc
class _$OfficeEntityCopyWithImpl<$Res, $Val extends OfficeEntity>
    implements $OfficeEntityCopyWith<$Res> {
  _$OfficeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radius = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfficeEntityImplCopyWith<$Res>
    implements $OfficeEntityCopyWith<$Res> {
  factory _$$OfficeEntityImplCopyWith(
          _$OfficeEntityImpl value, $Res Function(_$OfficeEntityImpl) then) =
      __$$OfficeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? nama,
      String? address,
      String? latitude,
      String? longitude,
      int? radius});
}

/// @nodoc
class __$$OfficeEntityImplCopyWithImpl<$Res>
    extends _$OfficeEntityCopyWithImpl<$Res, _$OfficeEntityImpl>
    implements _$$OfficeEntityImplCopyWith<$Res> {
  __$$OfficeEntityImplCopyWithImpl(
      _$OfficeEntityImpl _value, $Res Function(_$OfficeEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radius = freezed,
  }) {
    return _then(_$OfficeEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeEntityImpl implements _OfficeEntity {
  const _$OfficeEntityImpl(
      {this.id,
      this.nama,
      this.address,
      this.latitude,
      this.longitude,
      this.radius});

  factory _$OfficeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeEntityImplFromJson(json);

  @override
  final int? id;
  @override
  final String? nama;
  @override
  final String? address;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  final int? radius;

  @override
  String toString() {
    return 'OfficeEntity(id: $id, nama: $nama, address: $address, latitude: $latitude, longitude: $longitude, radius: $radius)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radius, radius) || other.radius == radius));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nama, address, latitude, longitude, radius);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeEntityImplCopyWith<_$OfficeEntityImpl> get copyWith =>
      __$$OfficeEntityImplCopyWithImpl<_$OfficeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeEntityImplToJson(
      this,
    );
  }
}

abstract class _OfficeEntity implements OfficeEntity {
  const factory _OfficeEntity(
      {final int? id,
      final String? nama,
      final String? address,
      final String? latitude,
      final String? longitude,
      final int? radius}) = _$OfficeEntityImpl;

  factory _OfficeEntity.fromJson(Map<String, dynamic> json) =
      _$OfficeEntityImpl.fromJson;

  @override
  int? get id;
  @override
  String? get nama;
  @override
  String? get address;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  int? get radius;
  @override
  @JsonKey(ignore: true)
  _$$OfficeEntityImplCopyWith<_$OfficeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
