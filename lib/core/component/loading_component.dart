import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'text_component.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key, required this.isLoading, this.color});

  final RxBool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading.isTrue
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                color: color ?? ColorApp.black.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: color == null ? ColorApp.white : ColorApp.info,
                    ),
                    const SizedBox(height: 7),
                    TextP(
                      text: 'Loading',
                      color: color == null ? ColorApp.white : ColorApp.info,
                    )
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
