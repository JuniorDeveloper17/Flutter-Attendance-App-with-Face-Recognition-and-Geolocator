import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../entity/shift_entity.dart';

abstract class ShiftRepository {
  Future<Either<Failur, ShiftEntity>> get(int id);
}
