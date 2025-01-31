import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/dialog_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/utils/img.dart';
import '../../../service/routes/route_name.dart';
import '../controller/izin_controller.dart';
import '../widget/card_izin.dart';

class IzinPage extends StatelessWidget {
  const IzinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<IzinController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const TextTitle(text: 'History Izin'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => Scrollbar(
            child: ListView.builder(
              controller: state.scrollController,
              itemCount: state.dataIzin.length + 1,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemBuilder: (context, index) {
                if (state.dataIzin.isEmpty && state.isLoading.isFalse) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      spacer((Get.height / 5).toInt()),
                      Image.asset(Img.noData),
                      const TextP(text: 'anda belum pernah melakukan izin')
                    ],
                  );
                } else {
                  if (index < state.dataIzin.length) {
                    final data = state.dataIzin[index];
                    return CardIzin(data: data);
                  } else {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => state.hasMore.isFalse
                                ? const TextC(
                                    text: 'semua data izin sudah di tampilkan')
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
        ontap: () {
          if (state.dep.user.value.status != 'Aktif') {
            dialogInfo(
              confirm: () => Get.back(),
              subtitle:
                  'Tidak dapat melakukan pengajuan izin karena status anda sedang tidak aktif',
            );
          } else {
            Get.toNamed(RouteName.addIzin);
          }
        },
        text: 'BUAT IZIN',
        size: const Size(150, 45),
      ),
    );
  }
}
