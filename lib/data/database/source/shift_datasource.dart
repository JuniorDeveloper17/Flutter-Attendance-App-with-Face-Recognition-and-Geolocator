import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../service/api/api.dart';
import '../../model/shift_model.dart';

abstract class ShiftDatasource {
  Future<ShiftModel> get(int id);
}

class ShiftDatasourceImpl extends ShiftDatasource {

  @override
  Future<ShiftModel> get(int id) async {
    try {
      final url = Uri.parse('${apiService.api.value}/shift/get/$id');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);
        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          return ShiftModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
