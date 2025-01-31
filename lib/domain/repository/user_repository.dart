import '../../core/error/error_class.dart';
import '../entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failur, UserEntity>> login(UserEntity param);
  Future<Either<Failur, UserEntity>> saveLoginStatus(UserEntity param);
  Future<Either<Failur, bool>> deleteLoginStatus();
  Future<Either<Failur, UserEntity>> getLoginStatus();
  Future<Either<Failur, UserEntity>> update(UserEntity param);
  Future<Either<Failur, UserEntity>> updatePassword(
    int userId,
    String password,
    String newPassword,
  );
}
