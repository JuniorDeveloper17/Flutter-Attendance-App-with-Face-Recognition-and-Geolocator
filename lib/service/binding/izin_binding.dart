import 'package:get/get.dart';
import '../../presentation/izin/controller/izin_controller.dart';

class IzinBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(IzinController());
  }
}
