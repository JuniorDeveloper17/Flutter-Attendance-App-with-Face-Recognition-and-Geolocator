// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftEntityImpl _$$ShiftEntityImplFromJson(Map<String, dynamic> json) =>
    _$ShiftEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      nama: json['nama'] as String?,
      waktuMasuk: json['waktuMasuk'] as String?,
      waktuKeluar: json['waktuKeluar'] as String?,
    );

Map<String, dynamic> _$$ShiftEntityImplToJson(_$ShiftEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'waktuMasuk': instance.waktuMasuk,
      'waktuKeluar': instance.waktuKeluar,
    };
