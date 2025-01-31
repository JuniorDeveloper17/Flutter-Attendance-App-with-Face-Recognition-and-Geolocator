import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/core/error/error_class.dart';
import 'package:presensi_universitas_bina_insan_app/data/database/source/attendance_datasource.dart';
import 'package:presensi_universitas_bina_insan_app/data/model/api_response_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/attendance_entity.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/attendance_repository.dart';

class AttendanceRepositoryImpl extends AttendanceRepository {
  final AttendanceDatasource attendanceDatasource;
  AttendanceRepositoryImpl(this.attendanceDatasource);

  @override
  Future<Either<Failur, AttendanceEntity>> presensiAdd(
      AttendanceEntity param) async {
    try {
      final result = await attendanceDatasource.presensiAdd(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, ApiResponse<List<AttendanceEntity>>>> getPresensi(
      int userId, int page) async {
    try {
      final result = await attendanceDatasource.getPresensi(userId, page);
      final modeling = result.data.map((e) => e.toEntity()).toList();

      return Right(ApiResponse(data: modeling, pagination: result.pagination));
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, AttendanceEntity>> presensiDetail(
      int attendanceId) async {
    try {
      final result = await attendanceDatasource.presensiDetail(attendanceId);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }
}
