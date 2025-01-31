import 'package:get/get.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import '../injection/dependency_injection.dart';

class DeviceService extends GetxController {
  final deviceInfo = MobileDeviceIdentifier();
  final dep = Get.find<DependencyInjection>();

  @override
  void onInit() {
    getDeviceId();
    super.onInit();
  }

  void getDeviceId() async {
    try {
      final data = await deviceInfo.getDeviceId();
      printInfo(info: '$data');
      dep.idDevice.value = '$data';
    } catch (e) {
      throw Exception(e);
    }
  }
}
