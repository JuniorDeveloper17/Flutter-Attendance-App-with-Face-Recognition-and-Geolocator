import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/core/error/error_class.dart';
import 'package:presensi_universitas_bina_insan_app/data/database/source/izin_datasource.dart';
import 'package:presensi_universitas_bina_insan_app/data/model/api_response_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/izin_entity.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/izin_repository.dart';

class IzinRepositoryImpl extends IzinRepository {
  final IzinDatasource izinDatasource;
  IzinRepositoryImpl(this.izinDatasource);

  @override
  Future<Either<Failur, IzinEntity>> addIzin(IzinEntity param) async {
    try {
      final result = await izinDatasource.addIzin(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, IzinEntity>> getDetailIzin(int izinId) async {
    try {
      final result = await izinDatasource.getDetailIzin(izinId);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, ApiResponse<List<IzinEntity>>>> getIzin(
      int userId, int page) async {
    try {
      final result = await izinDatasource.getIzin(userId, page);
      final modeling = result.data.map((e) => e.toEntity()).toList();

      return Right(ApiResponse(data: modeling, pagination: result.pagination));
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, bool>> hapusIzin(int izinId) async {
    try {
      final result = await izinDatasource.hapusIzin(izinId);
      return Right(result);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }
}
