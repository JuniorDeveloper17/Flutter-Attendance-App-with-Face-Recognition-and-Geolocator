import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/image_view_component.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../service/routes/route_name.dart';
import '../controller/presensi_controller.dart';

class PresensiDetailPage extends StatelessWidget {
  const PresensiDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<PresensiController>();
    state.getDetailPresensi(Get.arguments);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const TextTitle(text: 'Detail Presensi'),
      ),
      body: Obx(() => state.isLoading.isTrue
          ? LoadingComponent(
              isLoading: state.isLoading,
              color: ColorApp.white,
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(30),
              children: [
                InkWell(
                  onTap: () => Get.toNamed(
                    RouteName.locationPresensiView,
                    arguments:
                        '${state.detailPresensi.value.checkinLocation},${state.detailPresensi.value.checkoutLocation}',
                  ),
                  child: Container(
                    height: 150,
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ColorApp.info,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: ColorApp.secondary.withOpacity(0.5),
                              blurRadius: 3)
                        ]),
                    child: Stack(
                      children: [
                        Image.asset(Img.map),
                        const Align(
                          alignment: Alignment.topRight,
                          child: TextP(
                            text: 'Lihat Lokasi Presensi Di Map',
                            color: ColorApp.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                spacer(20),
                Row(
                  children: [
                    itemWidget(
                      'waktu masuk',
                      MyIcon.time2,
                      TimeFormatter().formatTime(DateTime.parse(
                          state.detailPresensi.value.createdAt!)),
                      null,
                    ),
                    const SizedBox(width: 20),
                    itemWidget(
                      'waktu keluar',
                      MyIcon.time2,
                      state.detailPresensi.value.updatedAt ==
                              state.detailPresensi.value.createdAt
                          ? ''
                          : TimeFormatter().formatTime(DateTime.parse(
                              state.detailPresensi.value.updatedAt!)),
                      null,
                    )
                  ],
                ),
                spacer(20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: ColorApp.white, boxShadow: [
                    BoxShadow(
                        color: ColorApp.secondary.withOpacity(0.3),
                        blurRadius: 3)
                  ]),
                  child: Column(
                    children: [
                      spacer(15),
                      listTile(
                        'Nama',
                        '${state.detailPresensi.value.idKaryawan}',
                      ),
                      spacer(15),
                      listTile(
                        'Office',
                        state.detailPresensi.value.office ?? 'nan',
                      ),
                      spacer(15),
                      listTile(
                        'Shift',
                        state.detailPresensi.value.shift ?? 'nan',
                      ),
                      spacer(15),
                      listTile(
                        'Status',
                        state.detailPresensi.value.status ?? 'nan',
                      ),
                      spacer(15),
                      listTile(
                        'Tanggal',
                        TimeFormatter().formatDate(DateTime.parse(
                            state.detailPresensi.value.createdAt!)),
                      ),
                      spacer(15),
                      listTile(
                        'Durasi Kerja',
                        state.detailPresensi.value.durasiKerja ?? 'nan',
                      ),
                      spacer(15),
                    ],
                  ),
                ),
                spacer(20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: ColorApp.white, boxShadow: [
                    BoxShadow(
                        color: ColorApp.secondary.withOpacity(0.3),
                        blurRadius: 3)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const TextP(
                            text: 'Foto Masuk',
                            color: ColorApp.success,
                          ),
                          spacer(5),
                          InkWell(
                            onTap: () => Get.to(ImageViewComponent(
                                url:
                                    '${state.detailPresensi.value.checkinImage}')),
                            child: Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorApp.secondary),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${state.detailPresensi.value.checkinImage}'))),
                              child: const Icon(
                                MyIcon.resizeFull,
                                color: ColorApp.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const TextP(
                            text: 'Foto Keluar',
                            color: ColorApp.success,
                          ),
                          spacer(5),
                          InkWell(
                            onTap: () => state
                                        .detailPresensi.value.durasiKerja ==
                                    ''
                                ? null
                                : Get.to(ImageViewComponent(
                                    url:
                                        '${state.detailPresensi.value.checkoutImage}')),
                            child: Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.bottomRight,
                              decoration: state
                                          .detailPresensi.value.durasiKerja ==
                                      ''
                                  ? BoxDecoration(
                                      color:
                                          ColorApp.secondary.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    )
                                  : BoxDecoration(
                                      border:
                                          Border.all(color: ColorApp.secondary),
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${state.detailPresensi.value.checkoutImage}'))),
                              child: const Icon(
                                MyIcon.resizeFull,
                                color: ColorApp.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                spacer(20),
                ButtonComponent(
                  ontap: () => Get.back(),
                  text: 'Kembali',
                )
              ],
            )),
    );
  }

  Expanded itemWidget(
      String title, IconData icon, String subtitle, Color? color) {
    return Expanded(
        child: Column(
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
    ));
  }

  Row listTile(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextP(
          text: title,
          color: ColorApp.warning,
        ),
        TextP(text: subtitle),
      ],
    );
  }
}
