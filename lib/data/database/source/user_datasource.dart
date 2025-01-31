import 'dart:convert';
import '../../../domain/entity/user_entity.dart';
import 'package:http/http.dart' as http;
import '../../../service/api/api.dart';
import '../../model/user_model.dart';

abstract class UserDatasource {
  Future<UserModel> login(UserEntity param);
  Future<UserModel> update(UserEntity param);
  Future<UserModel> updatePassword(
    int userId,
    String password,
    String newPassword,
  );
}

class UserDatasourceImpl extends UserDatasource {
  @override
  Future<UserModel> login(UserEntity param) async {
    try {
      final url = Uri.parse('${apiService.api.value}/karyawan/login');
      final data = UserModel.fromEntity(param)
          .toJson()
          .map((key, value) => MapEntry(key, value?.toString() ?? ""));
      final response = await http.post(url, body: data);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception('${decode['message']}');
        } else {
          return UserModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> update(UserEntity param) async {
    try {
      final url =
          Uri.parse('${apiService.api.value}/karyawan/update?_method=PATCH');
      final request = http.MultipartRequest('POST', url);

      if (param.foto != '' && param.foto != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          param.foto!,
        ));
        //==>hilangkan null
        request.fields.addAll(UserModel.fromEntity(param)
            .toJson()
            .map((key, value) => MapEntry(key, value?.toString() ?? "")));
      } else {
        request.fields.addAll(UserModel.fromEntity(param)
            .toJson()
            .map((key, value) => MapEntry(key, value?.toString() ?? "")));
      }

      final response = await request.send();
      final responseString = await http.Response.fromStream(response);
      final decode = json.decode(responseString.body);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        if (decode['success'] == false) {
          throw Exception('${decode['message']}');
        } else {
          return UserModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> updatePassword(
      int userId, String password, String newPassword) async {
    try {
      final url = Uri.parse(
          '${apiService.api.value}/karyawan/updatePassword?_method=PATCH');
      final data = {
        "id": userId.toString(),
        "password": password,
        "new_password": newPassword
      };
      final response = await http.post(url, body: data);
      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception('${decode['message']}');
        } else {
          return UserModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
