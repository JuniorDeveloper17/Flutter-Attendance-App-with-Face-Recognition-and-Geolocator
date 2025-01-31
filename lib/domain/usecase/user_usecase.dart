import 'package:dartz/dartz.dart';

import '../../core/error/error_class.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class LoginUsecase {
  final UserRepository userRepository;
  LoginUsecase(this.userRepository);

  Future<Either<Failur, UserEntity>> call(UserEntity param) async {
    return await userRepository.login(param);
  }
}

class SaveLoginStatusUsecase {
  final UserRepository userRepository;
  SaveLoginStatusUsecase(this.userRepository);

  Future<Either<Failur, UserEntity>> call(UserEntity param) async {
    return await userRepository.saveLoginStatus(param);
  }
}

class DeleteLoginStatus {
  final UserRepository userRepository;
  DeleteLoginStatus(this.userRepository);

  Future<Either<Failur, bool>> call() async {
    return await userRepository.deleteLoginStatus();
  }
}

class GetLoginStatusUsecase {
  final UserRepository userRepository;
  GetLoginStatusUsecase(this.userRepository);

  Future<Either<Failur, UserEntity>> call() async {
    return await userRepository.getLoginStatus();
  }
}

class UpdateUserUsecase {
  final UserRepository userRepository;
  UpdateUserUsecase(this.userRepository);

  Future<Either<Failur, UserEntity>> call(UserEntity param) async {
    return await userRepository.update(param);
  }
}

class UpdatePaswordUserUsecase {
  final UserRepository userRepository;
  UpdatePaswordUserUsecase(this.userRepository);

  Future<Either<Failur, UserEntity>> call(
    int userId,
    String password,
    String newPassword,
  ) async {
    return await userRepository.updatePassword(
      userId,
      password,
      newPassword,
    );
  }
}
