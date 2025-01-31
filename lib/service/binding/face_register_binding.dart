import 'package:get/get.dart';
import '../../presentation/face_register/controller/face_register_controller.dart';

class FaceRegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FaceRegisterController());
  }
}
