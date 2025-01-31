import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_entity.freezed.dart';
part 'location_entity.g.dart';

@freezed
class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    int? id,
    int? idKaryawan,
    String? idDevice,
    String? distance,
    String? location,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
  }) = _LocationEntity;

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);
}