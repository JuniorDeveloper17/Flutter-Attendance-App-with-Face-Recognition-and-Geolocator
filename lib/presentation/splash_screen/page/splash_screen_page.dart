import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/img.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        height: Get.height,
        width: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spacer(30),
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                  color: ColorApp.white,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(image: AssetImage(Img.logo))),
            ),
          ],
        ),
      ),
    );
  }
}
