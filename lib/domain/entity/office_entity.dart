import 'package:freezed_annotation/freezed_annotation.dart';
part 'office_entity.freezed.dart';
part 'office_entity.g.dart';

@freezed
class OfficeEntity with _$OfficeEntity {
  const factory OfficeEntity({
    int? id,
    String? nama,
    String? address,
    String? latitude,
    String? longitude,
    int? radius,
  }) = _OfficeEntity;

  factory OfficeEntity.fromJson(Map<String, dynamic> json) =>
      _$OfficeEntityFromJson(json);
}