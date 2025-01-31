// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izin_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IzinEntityImpl _$$IzinEntityImplFromJson(Map<String, dynamic> json) =>
    _$IzinEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      idKaryawan: (json['idKaryawan'] as num?)?.toInt(),
      keterangan: json['keterangan'] as String?,
      keteranganLanjutan: json['keteranganLanjutan'] as String?,
      document: json['document'] as String?,
      status: json['status'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$IzinEntityImplToJson(_$IzinEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idKaryawan': instance.idKaryawan,
      'keterangan': instance.keterangan,
      'keteranganLanjutan': instance.keteranganLanjutan,
      'document': instance.document,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
