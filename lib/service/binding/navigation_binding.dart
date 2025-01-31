import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/home/controller/home_controller.dart';
import 'package:presensi_universitas_bina_insan_app/service/time/time_service.dart';
import '../../presentation/navigation/controller/navigation_controller.dart';

class NavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TimeService());
    Get.put(NavigationController());
    Get.put(HomeController());
  }
}
