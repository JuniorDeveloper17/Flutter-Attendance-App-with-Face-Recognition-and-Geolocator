import 'package:freezed_annotation/freezed_annotation.dart';
part 'shift_entity.freezed.dart';
part 'shift_entity.g.dart';

@freezed
class ShiftEntity with _$ShiftEntity {
  const factory ShiftEntity({
    int? id,
    String? nama,
    String? waktuMasuk,
    String? waktuKeluar,
  }) = _ShiftEntity;

  factory ShiftEntity.fromJson(Map<String, dynamic> json) =>
      _$ShiftEntityFromJson(json);
}