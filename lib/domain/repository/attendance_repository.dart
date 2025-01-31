import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/attendance_entity.dart';
import '../../core/error/error_class.dart';
import '../../data/model/api_response_model.dart';

abstract class AttendanceRepository {
  Future<Either<Failur, AttendanceEntity>> presensiAdd(AttendanceEntity param);
  Future<Either<Failur, ApiResponse<List<AttendanceEntity>>>> getPresensi(
    int userId,
    int page,
  );
  Future<Either<Failur,AttendanceEntity>> presensiDetail(int attendanceId);
}
