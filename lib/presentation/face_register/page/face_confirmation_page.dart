import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:presensi_universitas_bina_insan_app/core/component/button_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/loading_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/face_register/controller/face_register_controller.dart';

import '../../../core/component/text_component.dart';

class FaceConfirmationPage extends StatelessWidget {
  const FaceConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<FaceRegisterController>();
    final img.Image image = Get.arguments as img.Image;
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop == true) {
          state.kedipanMata.value = 1;
          state.streamCamera();
        }
      },
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: const TextTitle(text: 'Konfirmasi'),
              ),
              body: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorApp.info),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                                Uint8List.fromList(img.encodePng(image))))),
                  ),
                  spacer(20),
                  const TextH1(text: 'Peringatan', color: ColorApp.danger),
                  spacer(5),
                  const TextP(
                      text:
                          'konfirmasi registrasi wajah anda, anda hanya dapat melakukan registrasi wajah sekali, jika ingin melakukan registrasi ulang wajah silahkan hubungi administrator.'),
                  spacer(10),
                  ButtonComponent(
                    ontap: () {
                      state.saveEmbedding();
                    },
                    text: 'Lanjutkan',
                  )
                ],
              )),
          LoadingComponent(isLoading: state.isLoading)
        ],
      ),
    );
  }
}
