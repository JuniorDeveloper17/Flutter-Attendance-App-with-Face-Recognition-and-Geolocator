import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/icons.dart';

Widget wajahTerdeteksi() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Card(
      color: ColorApp.primary.withOpacity(0.2),
      child: const ListTile(
        title: AutoSizeText(
          'Wajah Terdeteksi',
          style: TextStyle(
            color: ColorApp.primary,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          'Wajah anda telah terdeteksi silahkan ambil posisi terbaik anda dan tekan tombol di bawah untuk melanjutkan',
          style: TextStyle(color: ColorApp.white),
        ),
        //  leading: Icon(
        //    MyIcons.attendance,
        //   color: Colorx.white,
        //   size: 20,
        //  ),
      ),
    ),
  );
}

Widget wajahTidakTerdeteksi() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Card(
      color: ColorApp.danger.withOpacity(0.5),
      child: const ListTile(
        enabled: true,
        title: Text(
          'Wajah Tidak Terdeteksi',
          style: TextStyle(
            color: ColorApp.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          'Periksa pencahayaan kamera anda dan coba scan wajah anda kembali',
          style: TextStyle(color: ColorApp.white),
        ),
        leading: Icon(
          MyIcon.attendance,
          color: ColorApp.danger,
          size: 20,
        ),
      ),
    ),
  );
}

Widget verifyKedipanMata() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Card(
      color: ColorApp.primary.withOpacity(0.5),
      child: const ListTile(
        title: AutoSizeText(
          'Vertifikasi Kedipan Mata',
          style: TextStyle(
            color: ColorApp.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Kedipkan mata untuk melanjutkan',
          style: TextStyle(color: ColorApp.white),
        ),
        leading: Icon(
          MyIcon.attendance,
          color: ColorApp.white,
          size: 40,
        ),
      ),
    ),
  );
}
