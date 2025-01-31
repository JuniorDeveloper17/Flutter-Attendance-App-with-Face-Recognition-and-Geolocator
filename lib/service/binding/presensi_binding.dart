import 'package:get/get.dart';
import '../../presentation/presensi/controller/presensi_add_controller.dart';
import '../../presentation/presensi/controller/presensi_controller.dart';

class PresensiBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PresensiController());
  }
}

class PresensiAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PresensiAddController());
  }
}