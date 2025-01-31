import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../entity/office_entity.dart';
import '../repository/office_repository.dart';

class OfficeGetUsecase {
  final OfficeRepository officeRepository;
  OfficeGetUsecase(this.officeRepository);

  Future<Either<Failur, OfficeEntity>> call(int id) async {
    return await officeRepository.get(id);
  }
}
