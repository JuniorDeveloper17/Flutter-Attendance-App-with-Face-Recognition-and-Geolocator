import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../entity/shift_entity.dart';
import '../repository/shift_repository.dart';

class ShiftGetUsecase {
  final ShiftRepository shiftRepository;
  ShiftGetUsecase(this.shiftRepository);

  Future<Either<Failur, ShiftEntity>> call(int id) async {
    return await shiftRepository.get(id);
  }
}
