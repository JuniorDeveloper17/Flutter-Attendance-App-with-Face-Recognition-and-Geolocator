import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../entity/office_entity.dart';

abstract class OfficeRepository {
  Future<Either<Failur, OfficeEntity>> get(int id);
}
