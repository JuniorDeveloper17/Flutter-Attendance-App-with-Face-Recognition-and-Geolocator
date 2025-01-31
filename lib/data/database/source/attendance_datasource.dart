import 'dart:convert';

import 'package:presensi_universitas_bina_insan_app/data/model/attendance_model.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/attendance_entity.dart';
import 'package:http/http.dart' as http;

import '../../../service/api/api.dart';
import '../../model/api_response_model.dart';
import '../../model/pagination_model.dart';

abstract class AttendanceDatasource {
  Future<AttendanceModel> presensiAdd(AttendanceEntity param);
  Future<ApiResponse<List<AttendanceModel>>> getPresensi(int userId, int page);
  Future<AttendanceModel> presensiDetail(int attendaceId);
}

class AttendanceDatasourceImpl extends AttendanceDatasource {
  @override
  Future<AttendanceModel> presensiAdd(AttendanceEntity param) async {
    try {
      final url = Uri.parse('${apiService.api.value}/attendance/create');
      final request = http.MultipartRequest('POST', url);

      if (param.checkinImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'checkin_image',
          param.checkinImage!,
        ));
      }
      if (param.checkoutImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'checkout_image',
          param.checkoutImage!,
        ));
      }

      request.fields.addAll(AttendanceModel.fromEntity(param)
          .toJson()
          .map((key, value) => MapEntry(key, value?.toString() ?? "")));

      final response = await request.send();
      final responseString = await http.Response.fromStream(response);
      final decode = json.decode(responseString.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(decode['message']);
      } else {
        if (decode['success'] == false) {
          throw Exception('${decode['message']}');
        } else {
          return AttendanceModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AttendanceModel> presensiDetail(int attendaceId) async {
    try {
      final url = Uri.parse('${apiService.api.value}/attendance/detail/$attendaceId');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          return AttendanceModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ApiResponse<List<AttendanceModel>>> getPresensi(
      int userId, int page) async {
    try {
      final url = Uri.parse('${apiService.api.value}/attendance/get/$userId?page=$page');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          final data = List.from(decode['data']['data'])
              .map((e) => AttendanceModel.fromJson(e))
              .toList();

          final pagination = PaginationModel.fromJson(decode['data']);
          return ApiResponse(data: data, pagination: pagination);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
