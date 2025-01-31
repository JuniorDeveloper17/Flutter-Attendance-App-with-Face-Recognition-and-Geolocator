import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../../domain/entity/location_entity.dart';
import '../../domain/repository/location_repository.dart';
import '../database/source/location_datasource.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl(this.locationDatasource);

  @override
  Future<Either<Failur, LocationEntity>> send(LocationEntity param) async {
    try {
      final result = await locationDatasource.send(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: 'error', message: '$e'));
    }
  }
}
