import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/dialog_component.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/image_view_component.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/time_formatter.dart';
import '../controller/izin_controller.dart';

class IzinDetailPage extends StatelessWidget {
  const IzinDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<IzinController>();

    state.getDetailIzin(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const TextTitle(text: 'Detail Izin'),
      ),
      body: Obx(() => state.isLoading.isTrue
          ? LoadingComponent(
              isLoading: state.isLoading,
              color: ColorApp.white,
            )
          : ListView(
              padding: const EdgeInsets.all(30),
              children: [
                itemWidget(
                    'Tanggal',
                    MyIcon.izin,
                    TimeFormatter().formatDate(
                        DateTime.parse(state.detailIzin.value.createdAt!)),
                    null),
                spacer(10),
                Row(
                  children: [
                    Flexible(
                      child: itemWidget(
                        'Status',
                        state.detailIzin.value.status == true
                            ? MyIcon.done
                            : MyIcon.close,
                        state.detailIzin.value.status == true
                            ? 'Di setujui'
                            : 'Di tinjau',
                        state.detailIzin.value.status == true
                            ? ColorApp.success
                            : ColorApp.danger,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: itemWidget(
                        'Tipe',
                        Icons.short_text,
                        '${state.detailIzin.value.keterangan}',
                        null,
                      ),
                    ),
                  ],
                ),
                spacer(20),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(color: ColorApp.white, boxShadow: [
                      BoxShadow(
                        color: ColorApp.secondary.withOpacity(0.3),
                        blurRadius: 3,
                      )
                    ]),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Row(
                        children: [
                          Icon(
                            MyIcon.edit,
                            color: ColorApp.info,
                          ),
                          TextH2(text: '  Keterangan'),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: TextP(
                          text: '${state.detailIzin.value.keteranganLanjutan}',
                        ),
                      ),
                    )),
                spacer(10),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Row(
                      children: [
                        Icon(
                          MyIcon.contentPaste,
                          color: ColorApp.info,
                        ),
                        TextH2(text: '  Dokumen'),
                      ],
                    ),
                    subtitle: state.detailIzin.value.document == null
                        ? const TextP(text: 'tidak ada dokumen')
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 250,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorApp.info),
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${state.detailIzin.value.document}'),
                                ),
                              ),
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  onPressed: () => Get.to(ImageViewComponent(
                                        url:
                                            '${state.detailIzin.value.document}',
                                      )),
                                  icon: const Icon(
                                    MyIcon.resizeFull,
                                    color: ColorApp.danger,
                                    size: 25,
                                  )),
                            ),
                          )),
                Row(
                  children: [
                    state.detailIzin.value.status != true
                        ? Expanded(
                            child: ButtonComponent(
                              ontap: () => dialogKonfirm(
                                  cancel: () => Get.back(),
                                  confirm: () => state.hapusIzin(),
                                  subtitle:
                                      'anda yakin ingin membatalkan izin dengan menghapusnya?'),
                              text: 'Hapus',
                              backgroundColor: ColorApp.danger,
                            ),
                          )
                        : spacer(0),
                    state.detailIzin.value.status != true
                        ? const SizedBox(width: 20)
                        : spacer(0),
                    Expanded(
                      child: ButtonComponent(
                        ontap: () => Get.back(),
                        text: 'Kembali',
                      ),
                    )
                  ],
                )
              ],
            )),
    );
  }

  Column itemWidget(
      String title, IconData icon, String subtitle, Color? color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextP(
          text: title,
          color: ColorApp.black,
        ),
        spacer(5),
        Container(
          height: 40,
          decoration: BoxDecoration(color: ColorApp.white, boxShadow: [
            BoxShadow(
                color: ColorApp.secondary.withOpacity(0.3), blurRadius: 3),
          ]),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color ?? ColorApp.warning,
                ),
                child: Icon(
                  icon,
                  color: ColorApp.white,
                ),
              ),
              const SizedBox(width: 10),
              TextP(text: subtitle)
            ],
          ),
        ),
      ],
    );
  }
}
