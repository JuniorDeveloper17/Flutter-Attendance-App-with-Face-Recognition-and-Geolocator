import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/utils/img.dart';
import '../controller/location_controller.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<LocationController>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        children: [
          Image.asset(Img.permission),
          spacer(10),
          const TextH2(text: 'AKSES LOKASI DIBUTUHKAN'),
          spacer(10),
          Obx(() => TextP(
                text: state.isDeniedForever.isFalse
                    ? 'Halo untuk dapat melanjutkan izinkan aplikasi mengakses lokasi perangkat. Klik lanjutkan'
                    : 'izinkan aplikasi mengakses lokasi perangkat. Tekan lanjutkan masuk ke izin aplikasi, masuk ke lokasi, pilih selalu izinkan',
              )),
          spacer(20),
          ButtonComponent(
            ontap: () => state.requestPermission(),
            text: 'lanjutkan',
          )
        ],
      ),
    );
  }
}
