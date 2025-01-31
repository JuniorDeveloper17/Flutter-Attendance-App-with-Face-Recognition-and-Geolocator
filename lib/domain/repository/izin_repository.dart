import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/core/error/error_class.dart';
import 'package:presensi_universitas_bina_insan_app/data/model/api_response_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/izin_entity.dart';

abstract class IzinRepository {
  Future<Either<Failur, IzinEntity>> addIzin(IzinEntity param);
  Future<Either<Failur, ApiResponse<List<IzinEntity>>>> getIzin(
    int userId,
    int page,
  );
  Future<Either<Failur, IzinEntity>> getDetailIzin(int izinId);
   Future<Either<Failur, bool>> hapusIzin(int izinId);
}
