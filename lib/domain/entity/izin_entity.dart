import 'package:freezed_annotation/freezed_annotation.dart';
part 'izin_entity.freezed.dart';
part 'izin_entity.g.dart';

@freezed
class IzinEntity with _$IzinEntity {
  const factory IzinEntity({
    int? id,
    int? idKaryawan,
    String? keterangan,
    String? keteranganLanjutan,
    String? document,
    bool? status,
    String? createdAt,
    String? updatedAt,
  }) = _IzinEntity;

  factory IzinEntity.fromJson(Map<String, dynamic> json) =>
      _$IzinEntityFromJson(json);
}


