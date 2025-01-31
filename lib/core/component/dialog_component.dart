import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/color_theme.dart';

dialogKonfirm(
    {required VoidCallback cancel,
    required VoidCallback confirm,
    String? title,
    required String subtitle}) {
  return Get.defaultDialog(
      radius: 15,
      title: title ?? 'Konfirmasi',
      titleStyle: GoogleFonts.outfit(
          color: ColorApp.black, fontSize: 20, fontWeight: FontWeight.bold),
      middleText: subtitle,
      middleTextStyle: GoogleFonts.outfit(
        color: ColorApp.secondary,
        fontSize: 15,
      ),
      cancel: ElevatedButton(
        onPressed: cancel,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorApp.danger,
          fixedSize: const Size(100, 40),
        ),
        child: Text(
          'Batal',
          style: GoogleFonts.outfit(color: ColorApp.white, fontSize: 15),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: confirm,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorApp.info,
          fixedSize: const Size(100, 40),
        ),
        child: Text(
          'Oke',
          style: GoogleFonts.outfit(color: ColorApp.white, fontSize: 15),
        ),
      ));
}

dialogInfo({
  required VoidCallback confirm,
  String? title,
  required String subtitle,
  String? buttonTitle,
}) {
  return Get.defaultDialog(
      radius: 15,
      title: title ?? 'Info',
      titleStyle: GoogleFonts.outfit(
          color: ColorApp.black, fontSize: 20, fontWeight: FontWeight.bold),
      middleText: subtitle,
      middleTextStyle: GoogleFonts.outfit(
        color: ColorApp.secondary,
        fontSize: 15,
      ),
      confirm: ElevatedButton(
        onPressed: confirm,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorApp.info,
          fixedSize: Size(Get.width, 40),
        ),
        child: Text(
          buttonTitle ?? 'Kembali',
          style: GoogleFonts.outfit(color: ColorApp.white, fontSize: 15),
        ),
      ));
}
