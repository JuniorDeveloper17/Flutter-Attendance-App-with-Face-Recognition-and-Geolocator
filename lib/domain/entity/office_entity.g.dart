// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfficeEntityImpl _$$OfficeEntityImplFromJson(Map<String, dynamic> json) =>
    _$OfficeEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      nama: json['nama'] as String?,
      address: json['address'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      radius: (json['radius'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$OfficeEntityImplToJson(_$OfficeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };
