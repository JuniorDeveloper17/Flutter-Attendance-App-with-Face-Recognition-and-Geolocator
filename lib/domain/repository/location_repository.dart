import 'package:dartz/dartz.dart';

import '../../core/error/error_class.dart';
import '../entity/location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failur, LocationEntity>> send(LocationEntity param);
}