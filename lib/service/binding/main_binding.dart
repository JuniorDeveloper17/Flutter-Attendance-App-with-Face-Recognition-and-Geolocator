import 'package:get/get.dart';
import '../../presentation/splash_screen/controller/splash_screen_controller.dart';
import '../controller/main_controller.dart';
import '../device/device_service.dart';
import '../injection/dependency_injection.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DependencyInjection(), permanent: true);
    Get.put(DeviceService());
    Get.put(SplashScreenController());
    Get.put(MainController());
  }
}
