import 'package:freezed_annotation/freezed_annotation.dart';
part 'attendance_entity.freezed.dart';
part 'attendance_entity.g.dart';

@freezed
class AttendanceEntity with _$AttendanceEntity {
  const factory AttendanceEntity({
    int? id,
    String? checkinLocation,
    String? checkoutLocation,
    String? checkinImage,
    String? checkoutImage,
    String? durasiKerja,
    String? idDevice,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? office,
    String? shift,
    String? idKaryawan,
  }) = _AttendanceEntity;

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEntityFromJson(json);
}
