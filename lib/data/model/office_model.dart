import '../../domain/entity/office_entity.dart';

class OfficeModel {
  int? id;
  String? nama;
  String? address;
  String? latitude;
  String? longitude;
  int? radius;

  OfficeModel({
    this.id,
    this.nama,
    this.address,
    this.latitude,
    this.longitude,
    this.radius,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'],
      nama: json['nama'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };
  }

  factory OfficeModel.fromEntity(OfficeEntity entity) {
    return OfficeModel(
      id: entity.id,
      nama: entity.nama,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      radius: entity.radius,
    );
  }

  OfficeEntity toEntity() {
    return OfficeEntity(
      id: id,
      nama: nama,
      address: address,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );
  }
}
