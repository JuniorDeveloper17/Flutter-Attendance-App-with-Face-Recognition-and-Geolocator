import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/splash_screen/page/splash_screen_page.dart';

import '../../../core/component/snackbar_component.dart';
import '../../../service/api/api.dart';
import '../../../service/controller/main_controller.dart';
import '../../../service/device/device_service.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../splash_screen/controller/splash_screen_controller.dart';

class ApiController extends GetxController {
  final api = Get.find<Api>();
  final ip = TextEditingController();

  void changeApi() async {
    if (ip.text == '') {
      errorSnacbar('masukan alamat ip pengujian');
    } else {
      api.api.value = 'http://${ip.text}:8006/api';
      Get.put(DependencyInjection(), permanent: true);
      Get.put(DeviceService());
      Get.put(SplashScreenController());
      Get.put(MainController());
      Get.offAll(const SplashScreenPage());
    }
  }
}
