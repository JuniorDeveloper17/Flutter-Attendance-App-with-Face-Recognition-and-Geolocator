import '../../domain/entity/izin_entity.dart';



class IzinModel {
  int? id;
  int? idKaryawan;
  String? keterangan;
  String? keteranganLanjutan;
  String? document;
  bool? status;
  String? createdAt;
  String? updatedAt;

  IzinModel({
    this.id,
    this.idKaryawan,
    this.keterangan,
    this.keteranganLanjutan,
    this.document,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory IzinModel.fromJson(Map<String, dynamic> json) {
    return IzinModel(
      id: json['id'],
      idKaryawan: json['id_karyawan'],
      keterangan: json['keterangan'],
      keteranganLanjutan: json['keterangan_lanjutan'],
      document: json['document'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_karyawan': idKaryawan,
      'keterangan': keterangan,
      'keterangan_lanjutan': keteranganLanjutan,
      'document': document,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory IzinModel.fromEntity(IzinEntity entity) {
    return IzinModel(
      id: entity.id,
      idKaryawan: entity.idKaryawan,
      keterangan: entity.keterangan,
      keteranganLanjutan: entity.keteranganLanjutan,
      document: entity.document,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  IzinEntity toEntity() {
    return IzinEntity(
      id: id,
      idKaryawan: idKaryawan,
      keterangan: keterangan,
      keteranganLanjutan: keteranganLanjutan,
      document: document,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
