import '../../../domain/entity/attendance_entity.dart';

class AttendanceModel {
  int? id;
  String? checkinLocation;
  String? checkoutLocation;
  String? checkinImage;
  String? checkoutImage;
  String? durasiKerja;
  String? idDevice;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? office;
  String? shift;
  String? idKaryawan;

  AttendanceModel({
    this.id,
    this.checkinLocation,
    this.checkoutLocation,
    this.checkinImage,
    this.checkoutImage,
    this.durasiKerja,
    this.idDevice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.office,
    this.shift,
    this.idKaryawan,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      checkinLocation: json['checkin_location'],
      checkoutLocation: json['checkout_location'],
      checkinImage: json['checkin_image'],
      checkoutImage: json['checkout_image'],
      durasiKerja: json['durasi_kerja'],
      idDevice: json['id_device'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      office: json['office'],
      shift: json['shift'],
      idKaryawan: json['nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checkin_location': checkinLocation,
      'checkout_location': checkoutLocation,
      'checkin_image': checkinImage,
      'checkout_image': checkoutImage,
      'durasi_kerja': durasiKerja,
      'id_device': idDevice,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'office': office,
      'shift': shift,
      'nama': idKaryawan,
    };
  }

  // Konversi dari Entity ke Model
  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      checkinLocation: entity.checkinLocation,
      checkoutLocation: entity.checkoutLocation,
      checkinImage: entity.checkinImage,
      checkoutImage: entity.checkoutImage,
      durasiKerja: entity.durasiKerja,
      idDevice: entity.idDevice,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      office: entity.office,
      shift: entity.shift,
      idKaryawan: entity.idKaryawan,
    );
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      id: id,
      checkinLocation: checkinLocation,
      checkoutLocation: checkoutLocation,
      checkinImage: checkinImage,
      checkoutImage: checkoutImage,
      durasiKerja: durasiKerja,
      idDevice: idDevice,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      office: office,
      shift: shift,
      idKaryawan: idKaryawan,
    );
  }
}
