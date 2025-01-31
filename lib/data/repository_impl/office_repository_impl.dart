import 'package:dartz/dartz.dart';

import '../../core/error/error_class.dart';
import '../../domain/entity/office_entity.dart';
import '../../domain/repository/office_repository.dart';
import '../database/source/office_datasource.dart';

class OfficeRepositoryImpl extends OfficeRepository {
  final OfficeDatasource officeDatasource;
  OfficeRepositoryImpl(this.officeDatasource);

  @override
  Future<Either<Failur, OfficeEntity>> get(int id) async {
    try {
      final result = await officeDatasource.get(id);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: 'error', message: '$e'));
    }
  }
}
