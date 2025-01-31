import '../../domain/entity/shift_entity.dart';

class ShiftModel {
  int? id;
  String? nama;
  String? waktuMasuk;
  String? waktuKeluar;

  ShiftModel({
    this.id,
    this.nama,
    this.waktuMasuk,
    this.waktuKeluar,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'],
      nama: json['nama'],
      waktuMasuk: json['waktu_masuk'],
      waktuKeluar: json['waktu_keluar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'waktu_masuk': waktuMasuk,
      'waktu_keluar': waktuKeluar,
    };
  }

  factory ShiftModel.fromEntity(ShiftEntity entity) {
    return ShiftModel(
      id: entity.id,
      nama: entity.nama,
      waktuMasuk: entity.waktuMasuk,
      waktuKeluar: entity.waktuKeluar,
    );
  }

  ShiftEntity toEntity() {
    return ShiftEntity(
      id: id,
      nama: nama,
      waktuMasuk: waktuMasuk,
      waktuKeluar: waktuKeluar,
    );
  }
}
