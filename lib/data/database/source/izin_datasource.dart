import 'dart:convert';

import 'package:presensi_universitas_bina_insan_app/data/model/izin_model.dart';
import 'package:presensi_universitas_bina_insan_app/data/model/pagination_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/izin_entity.dart';
import 'package:presensi_universitas_bina_insan_app/service/api/api.dart';
import 'package:http/http.dart' as http;

import '../../model/api_response_model.dart';

abstract class IzinDatasource {
  Future<IzinModel> addIzin(IzinEntity param);
  Future<ApiResponse<List<IzinModel>>> getIzin(int userId, int page);
  Future<IzinModel> getDetailIzin(int izinId);
  Future<bool> hapusIzin(int izinId);
}

class IzinDatasourceImpl extends IzinDatasource {

  @override
  Future<IzinModel> addIzin(IzinEntity param) async {
    try {
      final url = Uri.parse('${apiService.api.value}/izin/create');
      final request = http.MultipartRequest('POST', url);
      if (param.document != '') {
        request.files.add(await http.MultipartFile.fromPath(
          'document',
          param.document!,
        ));

        request.fields.addAll(IzinModel.fromEntity(param)
            .toJson()
            .map((key, value) => MapEntry(key, value?.toString() ?? "")));
      } else {
        request.fields.addAll(IzinModel.fromEntity(param)
            .toJson()
            .map((key, value) => MapEntry(key, value?.toString() ?? "")));
      }

      final response = await request.send();
      final responseString = await http.Response.fromStream(response);
      final decode = json.decode(responseString.body);

      if (responseString.statusCode != 201) {
        throw Exception(decode['message']);
      } else {
        if (decode['success'] == false) {
          throw Exception('${decode['message']}');
        } else {
          return IzinModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<IzinModel> getDetailIzin(int izinId) async {
    try {
      final url = Uri.parse('${apiService.api.value}/izin/detail/$izinId');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          return IzinModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ApiResponse<List<IzinModel>>> getIzin(int userId, int page) async {
    try {
      final url = Uri.parse('${apiService.api.value}/izin/get/$userId?page=$page');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          final data = List.from(decode['data']['data'])
              .map((e) => IzinModel.fromJson(e))
              .toList();
          final pagination = PaginationModel.fromJson(decode['data']);
          return ApiResponse(data: data, pagination: pagination);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> hapusIzin(int izinId) async {
    try {
      final url = Uri.parse('${apiService.api.value}/izin/delete/$izinId');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          return true;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
