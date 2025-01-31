import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entity/user_entity.dart';
import '../../model/user_model.dart';

abstract class UserLocalsource {
  Future<UserModel> get();
  Future<UserModel> save(UserEntity param);
  Future<bool> delete();
}

class UserLocalsourceImpl extends UserLocalsource {
  @override
  Future<UserModel> get() async {
    final pref = await SharedPreferences.getInstance();
    try {
      final data = pref.getString('users');
      return UserModel.fromJson(json.decode(data!));
    } catch (e) {
      throw Exception('status login anda berakhir silahkan login kembali');
    }
  }

  @override
  Future<UserModel> save(UserEntity param) async {
    final pref = await SharedPreferences.getInstance();
    try {
      final data = json.encode(param);
      await pref.setString('users', data);
      return UserModel.fromEntity(param);
    } catch (e) {
      throw Exception('gagal menyimpan status login');
    }
  }

  @override
  Future<bool> delete() async {
    final pref = await SharedPreferences.getInstance();
    try {
      await pref.remove('users');
      return true;
    } catch (e) {
      throw Exception('gagal menghapus status login');
    }
  }
}
