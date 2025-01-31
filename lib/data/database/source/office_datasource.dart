import 'dart:convert';
import '../../../service/api/api.dart';
import '../../model/office_model.dart';
import 'package:http/http.dart' as http;

abstract class OfficeDatasource {
  Future<OfficeModel> get(int id);
}

class OfficeDatasourceImpl extends OfficeDatasource {
  final api = apiService.api.value;

  @override
  Future<OfficeModel> get(int id) async {
    try {
      final url = Uri.parse('${apiService.api.value}/office/get/$id');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('gagal terhubung ke server');
      } else {
        final decode = json.decode(response.body);

        if (decode['success'] == false) {
          throw Exception(decode['message']);
        } else {
          return OfficeModel.fromJson(decode['data']);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
