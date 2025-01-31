import 'package:dartz/dartz.dart';

import '../../core/error/error_class.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../database/local/user_localsource.dart';
import '../database/source/user_datasource.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource userDatasource;
  final UserLocalsource userLocalsource;
  UserRepositoryImpl(this.userDatasource, this.userLocalsource);

  @override
  Future<Either<Failur, UserEntity>> login(UserEntity param) async {
    try {
      final result = await userDatasource.login(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, UserEntity>> update(UserEntity param) async {
    try {
      final result = await userDatasource.update(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, UserEntity>> saveLoginStatus(UserEntity param) async {
    try {
      final result = await userLocalsource.save(param);
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, UserEntity>> getLoginStatus() async {
    try {
      final result = await userLocalsource.get();
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, bool>> deleteLoginStatus() async {
    try {
      final result = await userLocalsource.delete();
      return Right(result);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }

  @override
  Future<Either<Failur, UserEntity>> updatePassword(
      int userId, String password, String newPassword) async {
    try {
      final result = await userDatasource.updatePassword(
        userId,
        password,
        newPassword,
      );
      final modeling = result.toEntity();
      return Right(modeling);
    } catch (e) {
      return Left(Failur(status: '404', message: '$e'));
    }
  }
}
