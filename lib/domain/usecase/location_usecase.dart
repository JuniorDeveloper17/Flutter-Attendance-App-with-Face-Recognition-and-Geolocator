import 'package:dartz/dartz.dart';
import '../../core/error/error_class.dart';
import '../entity/location_entity.dart';
import '../repository/location_repository.dart';

class LocationSenUsecase {
  final LocationRepository locationRepository;
  LocationSenUsecase(this.locationRepository);

  Future<Either<Failur, LocationEntity>> call(LocationEntity param) async {
    return await locationRepository.send(param);
  }
}