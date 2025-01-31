import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    int? id,
    String? nip,
    String? nama,
    String? email,
    String? password,
    String? alamat,
    String? jenisKelamin,
    String? tanggalLahir,
    String? foto,
    String? noTelp,
    bool? wfa,
    String? status,
    String? faceId,
    String? idDevice,
    int? idShift,
    int? idOffice,
    String? createdAt,
    String? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
//dart run C:/Users/ryanh/flutter_code_generator/bin/generate_domain_layer.dart attendance 