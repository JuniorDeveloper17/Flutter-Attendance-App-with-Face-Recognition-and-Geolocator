import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/core/error/error_class.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/attendance_entity.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/attendance_repository.dart';

import '../../data/model/api_response_model.dart';

class PresensiAddUsecase {
  final AttendanceRepository attendanceRepository;
  PresensiAddUsecase(this.attendanceRepository);

  Future<Either<Failur, AttendanceEntity>> call(AttendanceEntity param) async {
    return await attendanceRepository.presensiAdd(param);
  }
}

class GetPresensiUsecase {
  final AttendanceRepository attendanceRepository;
  GetPresensiUsecase(this.attendanceRepository);

  Future<Either<Failur, ApiResponse<List<AttendanceEntity>>>> call(
      int userId, int page) async {
    return await attendanceRepository.getPresensi(userId, page);
  }
}

class DetailPresensiUsecase {
  final AttendanceRepository attendanceRepository;
  DetailPresensiUsecase(this.attendanceRepository);

  Future<Either<Failur, AttendanceEntity>> call(int attendanceId) async {
    return await attendanceRepository.presensiDetail(attendanceId);
  }
}
