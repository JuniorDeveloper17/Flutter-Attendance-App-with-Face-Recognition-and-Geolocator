import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entity/location_entity.dart';
import '../../../service/api/api.dart';
import '../../model/location_model.dart';

abstract class LocationDatasource {
  Future<LocationModel> send(LocationEntity param);
}

class LocationDatasourceImpl extends LocationDatasource {
  @override
  Future<LocationModel> send(LocationEntity param) async {
    final url = Uri.parse(
        '${apiService.api.value}/karyawan/sendLocation?_method=PATCH');
    final data = LocationModel.fromEntity(param)
        .toJson()
        .map((key, value) => MapEntry(key, value?.toString() ?? ""));
    final response = await http.post(url, body: data);
    if (response.statusCode != 200) {
      throw Exception('gagal terhubung ke server');
    } else {
      final decode = json.decode(response.body);

      if (decode['success'] == false) {
        throw Exception(decode['message']);
      } else {
        return LocationModel.fromJson(decode['data']);
      }
    }
  }
}
