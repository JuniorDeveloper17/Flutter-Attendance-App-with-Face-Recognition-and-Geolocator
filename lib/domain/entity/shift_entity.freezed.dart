// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShiftEntity _$ShiftEntityFromJson(Map<String, dynamic> json) {
  return _ShiftEntity.fromJson(json);
}

/// @nodoc
mixin _$ShiftEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  String? get waktuMasuk => throw _privateConstructorUsedError;
  String? get waktuKeluar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftEntityCopyWith<ShiftEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftEntityCopyWith<$Res> {
  factory $ShiftEntityCopyWith(
          ShiftEntity value, $Res Function(ShiftEntity) then) =
      _$ShiftEntityCopyWithImpl<$Res, ShiftEntity>;
  @useResult
  $Res call({int? id, String? nama, String? waktuMasuk, String? waktuKeluar});
}

/// @nodoc
class _$ShiftEntityCopyWithImpl<$Res, $Val extends ShiftEntity>
    implements $ShiftEntityCopyWith<$Res> {
  _$ShiftEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? waktuMasuk = freezed,
    Object? waktuKeluar = freezed,
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
      waktuMasuk: freezed == waktuMasuk
          ? _value.waktuMasuk
          : waktuMasuk // ignore: cast_nullable_to_non_nullable
              as String?,
      waktuKeluar: freezed == waktuKeluar
          ? _value.waktuKeluar
          : waktuKeluar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftEntityImplCopyWith<$Res>
    implements $ShiftEntityCopyWith<$Res> {
  factory _$$ShiftEntityImplCopyWith(
          _$ShiftEntityImpl value, $Res Function(_$ShiftEntityImpl) then) =
      __$$ShiftEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? nama, String? waktuMasuk, String? waktuKeluar});
}

/// @nodoc
class __$$ShiftEntityImplCopyWithImpl<$Res>
    extends _$ShiftEntityCopyWithImpl<$Res, _$ShiftEntityImpl>
    implements _$$ShiftEntityImplCopyWith<$Res> {
  __$$ShiftEntityImplCopyWithImpl(
      _$ShiftEntityImpl _value, $Res Function(_$ShiftEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? waktuMasuk = freezed,
    Object? waktuKeluar = freezed,
  }) {
    return _then(_$ShiftEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      waktuMasuk: freezed == waktuMasuk
          ? _value.waktuMasuk
          : waktuMasuk // ignore: cast_nullable_to_non_nullable
              as String?,
      waktuKeluar: freezed == waktuKeluar
          ? _value.waktuKeluar
          : waktuKeluar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftEntityImpl implements _ShiftEntity {
  const _$ShiftEntityImpl(
      {this.id, this.nama, this.waktuMasuk, this.waktuKeluar});

  factory _$ShiftEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftEntityImplFromJson(json);

  @override
  final int? id;
  @override
  final String? nama;
  @override
  final String? waktuMasuk;
  @override
  final String? waktuKeluar;

  @override
  String toString() {
    return 'ShiftEntity(id: $id, nama: $nama, waktuMasuk: $waktuMasuk, waktuKeluar: $waktuKeluar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.waktuMasuk, waktuMasuk) ||
                other.waktuMasuk == waktuMasuk) &&
            (identical(other.waktuKeluar, waktuKeluar) ||
                other.waktuKeluar == waktuKeluar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nama, waktuMasuk, waktuKeluar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftEntityImplCopyWith<_$ShiftEntityImpl> get copyWith =>
      __$$ShiftEntityImplCopyWithImpl<_$ShiftEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftEntityImplToJson(
      this,
    );
  }
}

abstract class _ShiftEntity implements ShiftEntity {
  const factory _ShiftEntity(
      {final int? id,
      final String? nama,
      final String? waktuMasuk,
      final String? waktuKeluar}) = _$ShiftEntityImpl;

  factory _ShiftEntity.fromJson(Map<String, dynamic> json) =
      _$ShiftEntityImpl.fromJson;

  @override
  int? get id;
  @override
  String? get nama;
  @override
  String? get waktuMasuk;
  @override
  String? get waktuKeluar;
  @override
  @JsonKey(ignore: true)
  _$$ShiftEntityImplCopyWith<_$ShiftEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
