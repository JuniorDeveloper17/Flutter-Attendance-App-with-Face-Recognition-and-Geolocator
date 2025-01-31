// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceEntityImpl _$$AttendanceEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      checkinLocation: json['checkinLocation'] as String?,
      checkoutLocation: json['checkoutLocation'] as String?,
      checkinImage: json['checkinImage'] as String?,
      checkoutImage: json['checkoutImage'] as String?,
      durasiKerja: json['durasiKerja'] as String?,
      idDevice: json['idDevice'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      office: json['office'] as String?,
      shift: json['shift'] as String?,
      idKaryawan: json['idKaryawan'] as String?,
    );

Map<String, dynamic> _$$AttendanceEntityImplToJson(
        _$AttendanceEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkinLocation': instance.checkinLocation,
      'checkoutLocation': instance.checkoutLocation,
      'checkinImage': instance.checkinImage,
      'checkoutImage': instance.checkoutImage,
      'durasiKerja': instance.durasiKerja,
      'idDevice': instance.idDevice,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'office': instance.office,
      'shift': instance.shift,
      'idKaryawan': instance.idKaryawan,
    };
