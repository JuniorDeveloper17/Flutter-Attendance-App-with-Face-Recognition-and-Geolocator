import 'package:presensi_universitas_bina_insan_app/data/model/pagination_model.dart';

class ApiResponse<T> {
  final T data;
  final PaginationModel pagination;

  ApiResponse({required this.data, required this.pagination});
}