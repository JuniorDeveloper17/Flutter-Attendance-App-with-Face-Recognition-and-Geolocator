// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      nip: json['nip'] as String?,
      nama: json['nama'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      alamat: json['alamat'] as String?,
      jenisKelamin: json['jenisKelamin'] as String?,
      tanggalLahir: json['tanggalLahir'] as String?,
      foto: json['foto'] as String?,
      noTelp: json['noTelp'] as String?,
      wfa: json['wfa'] as bool?,
      status: json['status'] as String?,
      faceId: json['faceId'] as String?,
      idDevice: json['idDevice'] as String?,
      idShift: (json['idShift'] as num?)?.toInt(),
      idOffice: (json['idOffice'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nip': instance.nip,
      'nama': instance.nama,
      'email': instance.email,
      'password': instance.password,
      'alamat': instance.alamat,
      'jenisKelamin': instance.jenisKelamin,
      'tanggalLahir': instance.tanggalLahir,
      'foto': instance.foto,
      'noTelp': instance.noTelp,
      'wfa': instance.wfa,
      'status': instance.status,
      'faceId': instance.faceId,
      'idDevice': instance.idDevice,
      'idShift': instance.idShift,
      'idOffice': instance.idOffice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
