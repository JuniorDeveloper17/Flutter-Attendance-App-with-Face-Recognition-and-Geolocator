import '../../domain/entity/user_entity.dart';

class UserModel {
  int? id;
  String? nip;
  String? nama;
  String? email;
  String? password;
  String? alamat;
  String? jenisKelamin;
  String? tanggalLahir;
  String? foto;
  String? noTelp;
  bool? wfa;
  String? status;
  String? faceId;
  String? idDevice;
  int? idShift;
  int? idOffice;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.nip,
    this.nama,
    this.email,
    this.password,
    this.alamat,
    this.jenisKelamin,
    this.tanggalLahir,
    this.foto,
    this.noTelp,
    this.wfa,
    this.status,
    this.faceId,
    this.idDevice,
    this.idShift,
    this.idOffice,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nip: json['nip'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
      alamat: json['alamat'],
      jenisKelamin: json['jenis_kelamin'],
      tanggalLahir: json['tanggal_lahir'],
      foto: json['foto'],
      noTelp: json['no_telp'],
      wfa: json['wfa'],
      status: json['status'],
      faceId: json['face_id'],
      idDevice: json['id_device'],
      idShift: json['id_shift'],
      idOffice: json['id_office'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nip': nip,
      'nama': nama,
      'email': email,
      'password': password,
      'alamat': alamat,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': tanggalLahir,
      'foto': foto,
      'no_telp': noTelp,
      'wfa': wfa,
      'status': status,
      'face_id': faceId,
      'id_device': idDevice,
      'id_shift': idShift,
      'id_office': idOffice,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      nip: entity.nip,
      nama: entity.nama,
      email: entity.email,
      password: entity.password,
      alamat: entity.alamat,
      jenisKelamin: entity.jenisKelamin,
      tanggalLahir: entity.tanggalLahir,
      foto: entity.foto,
      noTelp: entity.noTelp,
      wfa: entity.wfa,
      status: entity.status,
      faceId: entity.faceId,
      idDevice: entity.idDevice,
      idShift: entity.idShift,
      idOffice: entity.idOffice,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      nip: nip,
      nama: nama,
      email: email,
      password: password,
      alamat: alamat,
      jenisKelamin: jenisKelamin,
      tanggalLahir: tanggalLahir,
      foto: foto,
      noTelp: noTelp,
      wfa: wfa,
      status: status,
      faceId: faceId,
      idDevice: idDevice,
      idShift: idShift,
      idOffice: idOffice,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
