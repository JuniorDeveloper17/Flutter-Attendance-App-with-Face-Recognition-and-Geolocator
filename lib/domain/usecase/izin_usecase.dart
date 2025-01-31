import 'package:dartz/dartz.dart';
import 'package:presensi_universitas_bina_insan_app/core/error/error_class.dart';
import 'package:presensi_universitas_bina_insan_app/data/model/api_response_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/izin_entity.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/izin_repository.dart';

class GetIzinUsecase {
  final IzinRepository izinRepository;
  GetIzinUsecase(this.izinRepository);

  Future<Either<Failur, ApiResponse<List<IzinEntity>>>> call(
      int userId, int page) async {
    return await izinRepository.getIzin(userId, page);
  }
}

class DetailIzinUsecase {
  final IzinRepository izinRepository;
  DetailIzinUsecase(this.izinRepository);

  Future<Either<Failur, IzinEntity>> call(int izinId) async {
    return await izinRepository.getDetailIzin(izinId);
  }
}

class AddIzinUsecase {
  final IzinRepository izinRepository;
  AddIzinUsecase(this.izinRepository);

  Future<Either<Failur, IzinEntity>> call(IzinEntity param) async {
    return await izinRepository.addIzin(param);
  }
}

class HapusIzinUsecase {
  final IzinRepository izinRepository;
  HapusIzinUsecase(this.izinRepository);

  Future<Either<Failur, bool>> call(int izinId) async {
    return await izinRepository.hapusIzin(izinId);
  }
}
