import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../../domain/entity/shift_entity.dart';
import '../../domain/repository/shift_repository.dart';
import '../database/source/shift_datasource.dart';

class ShiftRepositoryImpl extends ShiftRepository {
  final ShiftDatasource shiftDatasource;
  ShiftRepositoryImpl(this.shiftDatasource);

  @override
  Future<Either<Failur, ShiftEntity>> get(int id) async {
    try {
      final result = await shiftDatasource.get(id);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: 'error', message: '$e'));
    }
  }
}