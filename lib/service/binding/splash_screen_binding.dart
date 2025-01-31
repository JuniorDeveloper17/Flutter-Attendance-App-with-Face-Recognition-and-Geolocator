import 'package:get/get.dart';
import '../../presentation/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
