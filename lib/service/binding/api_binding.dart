import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/service/api/api.dart';
import '../../presentation/api/controller/api_controller.dart';

class ApiBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Api(), permanent: true);
    Get.put(ApiController());
  }
}
