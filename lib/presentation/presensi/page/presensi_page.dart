import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/utils/img.dart';
import '../../../service/routes/route_name.dart';
import '../controller/presensi_controller.dart';
import '../widget/card_presensi.dart';

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<PresensiController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const TextTitle(text: 'History Presensi'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => Scrollbar(
            child: ListView.builder(
              controller: state.scrollController,
              itemCount: state.dataPresensi.length + 1,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemBuilder: (context, index) {
                if (state.dataPresensi.isEmpty && state.isLoading.isFalse) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      spacer((Get.height / 5).toInt()),
                      Image.asset(Img.noData, height: Get.width * 0.5),
                      const TextP(text: 'anda belum pernah melakukan presensi')
                    ],
                  );
                } else {
                  if (index < state.dataPresensi.length) {
                    final data = state.dataPresensi[index];
                    return InkWell(
                        onTap: () => Get.toNamed(RouteName.detailPresensi,
                            arguments: data.id),
                        child: CardPresensi(data: data));
                  } else {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => state.hasMore.isFalse
                                ? const TextC(
                                    text:
                                        'semua data presensi sudah di tampilkan')
                                : const CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                          ),
                        ));
                  }
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: ButtonComponent(
        ontap: () => state.addPresensi(),
        text: 'BUAT PRESENSI',
        size: const Size(200, 45),
      ),
    );
  }
}
