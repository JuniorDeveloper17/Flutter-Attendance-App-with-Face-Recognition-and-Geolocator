import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/button_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/text_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/img.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/time_formatter.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/presensi/controller/presensi_controller.dart';
import 'package:presensi_universitas_bina_insan_app/service/injection/dependency_injection.dart';
import 'package:avatar_glow/avatar_glow.dart';

class PresensiKonfirmationPage extends StatelessWidget {
  const PresensiKonfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<PresensiController>();
    final dep = Get.find<DependencyInjection>();
    final data = state.dataPresensi.first;

    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(30),
      children: [
        spacer(30),
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorApp.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: ColorApp.secondary.withOpacity(0.5), blurRadius: 3)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AvatarGlow(
                        glowShape: BoxShape.circle,
                        glowColor: ColorApp.info,
                        glowRadiusFactor: 0.1,
                        child: const CircleAvatar(
                          radius: 100,
                        )),
                    Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Img.success))),
                    ),
                  ],
                ),
                TextH1(
                    text: data.durasiKerja == ''
                        ? 'ABSEN MASUK'
                        : 'ABSEN KELUAR'),
                spacer(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: listTile(
                        'Nama',
                        '${dep.user.value.nama}',
                      ),
                    ),
                    Flexible(
                      child: listTile(
                        'Jam',
                        data.durasiKerja == ''
                            ? TimeFormatter()
                                .formatTime(DateTime.parse(data.createdAt!))
                            : TimeFormatter()
                                .formatTime(DateTime.parse(data.updatedAt!)),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: listTile(
                        data.durasiKerja == '' ? 'Status' : 'Durasi',
                        data.durasiKerja == ''
                            ? '${data.status}'
                            : '${data.durasiKerja}',
                      ),
                    ),
                    Flexible(
                      child: listTile(
                        'Tanggal',
                        TimeFormatter()
                            .formatHMY(DateTime.parse(data.createdAt!)),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: listTile(
                        'Lokasi',
                        data.durasiKerja == ''
                            ? '${data.checkinLocation}'
                            : '${data.checkoutLocation}',
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.network(
                    data.durasiKerja == ''
                        ? '${data.checkinImage}'
                        : '${data.checkoutImage}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                spacer(20),
                ButtonComponent(
                  ontap: () => Get.back(),
                  text: 'Kembali',
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  ListTile listTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.person),
      title: AutoSizeText(
        title,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: ColorApp.secondary,
        ),
      ),
      subtitle: AutoSizeText(
        subtitle,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: ColorApp.black,
        ),
      ),
    );
  }
}
