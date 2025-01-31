import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/api/controller/api_controller.dart';
import '../../../core/component/form_component.dart';
import '../../../core/component/spacer_component.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ApiController>();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        spacer(20),
        FormComponent(
          controller: state.ip,
          hint: 'masukan alamat ip untuk pengujian',
        ),
        spacer(20),
        ElevatedButton(
          onPressed: () => state.changeApi(),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: ColorApp.warning,
              fixedSize: const Size(250, 45)),
          child: Text('Lanjutkan',
              style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.white)),
        )
      ]),
    ));
  }
}
