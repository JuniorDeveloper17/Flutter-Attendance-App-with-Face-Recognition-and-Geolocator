import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/img.dart';
import 'text_component.dart';

SnackbarController errorSnacbar(String messege) {
  return Get.snackbar('', '',
      duration: const Duration(seconds: 3),
      icon: Image.asset(Img.error, width: 20),
      titleText: const TextH2(
        text: 'Oppss',
        color: ColorApp.danger,
      ),
      messageText: TextP(text: messege, color: ColorApp.white));
}

SnackbarController successSnacbar(String messege) {
  return Get.snackbar('', '',
      icon: Image.asset(Img.success, width: 20),
      titleText: const TextH2(
        text: 'Okay',
        color: ColorApp.primary,
      ),
      messageText: TextP(text: messege, color: ColorApp.white));
}
