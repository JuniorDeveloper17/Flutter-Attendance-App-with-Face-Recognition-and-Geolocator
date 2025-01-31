import '../../domain/entity/location_entity.dart';

class LocationModel {
  int? id;
  int? idKaryawan;
  String? idDevice;
  String? distance;
  String? location;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  LocationModel({
    this.id,
    this.idKaryawan,
    this.idDevice,
    this.distance,
    this.location,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      idKaryawan: json['id_karyawan'],
      idDevice: json['id_device'],
      distance: json['distance'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_karyawan': idKaryawan,
      'id_device': idDevice,
      'distance': distance,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      idKaryawan: entity.idKaryawan,
      idDevice: entity.idDevice,
      distance: entity.distance,
      location: entity.location,
      latitude: entity.latitude,
      longitude: entity.longitude,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      idKaryawan: idKaryawan,
      idDevice: idDevice,
      distance: distance,
      location: location,
      latitude: latitude,
      longitude: longitude,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
