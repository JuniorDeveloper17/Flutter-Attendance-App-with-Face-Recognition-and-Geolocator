import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/button_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/text_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/img.dart';
import '../controller/location_controller.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<LocationController>();
    state.checkLocationPermission();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(Img.permission),
          spacer(20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.map_rounded),
            title: Obx(() => state.permissionStatus.isFalse
                ? const TextH2(text: 'Izin lokasi diperlukan')
                : state.serviceLocatorEnable.isFalse
                    ? const TextH2(text: 'Layanan lokasi harus di aktifkan')
                    : spacer(0)),
            subtitle: const TextP(
              text:
                  'Aplikasi memerlukan izin akses lokasi dan pengaktifan service lokasi, klik izinkan untuk melanjutkan',
            ),
          ),
          spacer(20),
          Obx(() => state.permissionStatus.isFalse
              ? ButtonComponent(
                  backgroundColor: ColorApp.info,
                  ontap: () => state.requestPermission(),
                  text: 'Izinkan aplikasi mengakses lokasi anda',
                )
              : state.serviceLocatorEnable.isFalse
                  ? ButtonComponent(
                      backgroundColor: ColorApp.info,
                      ontap: () async => await state.requestServiceLocator(),
                      text: 'Aktifkan layanan lokasi perangkat anda',
                    )
                  : spacer(0))
        ],
      ),
    );
  }
}
