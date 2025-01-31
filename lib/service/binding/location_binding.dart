import 'package:get/get.dart';
import '../../presentation/location/controller/location_controller.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LocationController(), permanent: true);
  }
}
