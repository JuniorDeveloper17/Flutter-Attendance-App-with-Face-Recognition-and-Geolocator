import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/component/dialog_component.dart';
import '../../../core/component/image_view_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../service/routes/route_name.dart';
import '../../presensi/controller/presensi_controller.dart';
import '../../presensi/widget/card_presensi.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeController>();

    return Scaffold(
        body: Column(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  height: 270,
                  width: Get.width,
                  Img.bgHome,
                  fit: BoxFit.fill,
                  color: const Color.fromARGB(255, 4, 29, 197),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacer(10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: TextTitle(
                          text: TimeFormatter()
                              .formatTimeName(state.time.time.value),
                          color: ColorApp.white,
                        ),
                        subtitle: TextP(
                          text: '${state.dep.user.value.nama}',
                          color: ColorApp.white,
                        ),
                        trailing: InkWell(
                          onTap: () => state.dep.user.value.foto != ''
                              ? Get.to(ImageViewComponent(
                                  url: state.dep.user.value.foto != null
                                      ? state.dep.user.value.foto!
                                      : state.dep.user.value.jenisKelamin ==
                                              'Laki Laki'
                                          ? Img.l
                                          : Img.p))
                              : null,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: ColorApp.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: ColorApp.white, width: 2),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: state.dep.user.value.foto == null
                                        ? state.dep.user.value.jenisKelamin ==
                                                'Laki Laki'
                                            ? const AssetImage(Img.l)
                                            : const AssetImage(Img.p)
                                        : NetworkImage(
                                            state.dep.user.value.foto!))),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(RouteName.locationView),
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.pin_drop,
                          color: ColorApp.info,
                          size: 25,
                        ),
                        title: Obx(
                          () => state.location.placemark?.value
                                      .administrativeArea ==
                                  null
                              ? const TextC(text: 'Loading tracking location')
                              : TextC(
                                  text:
                                      '${state.location.placemark?.value.administrativeArea}, ${state.location.placemark?.value.locality}, ${state.location.placemark?.value.subAdministrativeArea}, ${state.location.placemark?.value.subLocality}',
                                  color: ColorApp.white,
                                ),
                        ),
                      ),
                      spacer(10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorApp.primary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(
                                  left: BorderSide(
                                      color: ColorApp.white, width: 2),
                                  right: BorderSide(
                                      color: ColorApp.white, width: 2))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    MyIcon.jadwal,
                                    color: ColorApp.white,
                                    size: 15,
                                  ),
                                  Obx(
                                    () => TextP(
                                      text:
                                          ' ${TimeFormatter().formatDate(state.time.time.value)}',
                                      color: ColorApp.white,
                                    ),
                                  ),
                                  Expanded(child: spacer(0)),
                                  const Icon(
                                    MyIcon.time2,
                                    color: ColorApp.white,
                                    size: 15,
                                  ),
                                  TextP(
                                    text:
                                        ' ${state.dep.shift.value.waktuMasuk!.split(':')[0]}:${state.dep.shift.value.waktuMasuk!.split(':')[1]} - ${state.dep.shift.value.waktuKeluar!.split(':')[0]}:${state.dep.shift.value.waktuKeluar!.split(':')[1]}',
                                    color: ColorApp.white,
                                  )
                                ],
                              ),
                              spacer(10),
                              Obx(
                                () => AutoSizeText(
                                  TimeFormatter()
                                      .formatTime(state.time.time.value),
                                  style: GoogleFonts.outfit(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: ColorApp.white),
                                ),
                              ),
                              spacer(10),
                              TextC(
                                text:
                                    '${state.dep.office.value.nama} ${state.dep.shift.value.nama} radius presensi ${state.dep.office.value.radius} meter',
                                color: ColorApp.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              menuHome(
                'Presensi',
                Img.presensi,
                ColorApp.info.withOpacity(0.8),
                () => state.nav.changePage(1),
              ),
              Obx(
                () => menuHome(
                  'Face Register',
                  Img.faceRegister,
                  state.dep.user.value.faceId == null
                      ? ColorApp.danger
                      : ColorApp.success.withOpacity(0.8),
                  () => state.dep.user.value.faceId == null
                      ? Get.toNamed(RouteName.faceRegister)
                      : dialogInfo(
                          confirm: () => Get.back(),
                          subtitle:
                              'Anda sudah melakukan registrasi wajah, silahkan hubungi administrator untuk dapat melakukan registrasi ulang wajah',
                        ),
                ),
              ),
              menuHome(
                'Izin',
                Img.izin,
                ColorApp.info.withOpacity(0.8),
                () => state.nav.changePage(2),
              ),
            ],
          ),
        ),
        Divider(
          height: 30,
          thickness: 3,
          color: ColorApp.secondary.withOpacity(0.1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              const Icon(
                MyIcon.history,
                color: ColorApp.info,
                size: 25,
              ),
              const TextH2(text: '  History Presensi'),
              Expanded(child: spacer(0)),
              const TextP(
                text: 'terakhir 5 hari',
                color: ColorApp.info,
              )
            ],
          ),
        ),
        spacer(20),
        //==>
        Expanded(
            child: Obx(
          () => state.dataPresensi.isEmpty
              ? ListView(
                  children: [
                    Image.asset(Img.noData, height: Get.width * 0.5),
                    const Center(
                        child:
                            TextP(text: 'anda belum pernah melakukan presensi'))
                  ],
                )
              : historyPresensi(state),
        ))
      ],
    ));
  }

  Column menuHome(String title, String icon, Color color, VoidCallback ontap) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Image.asset(icon, width: 25)),
        ),
        spacer(5),
        AutoSizeText(
          title,
          style: GoogleFonts.outfit(
            color: ColorApp.black,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        )
      ],
    );
  }

  Container card1(HomeController state) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorApp.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextP(
            text: TimeFormatter().formatDate(state.time.time.value),
          ),
          Obx(
            () => AutoSizeText(
              TimeFormatter().formatTime(state.time.time.value),
              style: GoogleFonts.outfit(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.warning),
            ),
          ),
          const TextP(text: 'Jadwal anda hari ini'),
          spacer(5),
          TextC(
            text:
                '${state.dep.office.value.nama}, ${state.dep.shift.value.nama} ${state.dep.shift.value.waktuMasuk} - ${state.dep.shift.value.waktuKeluar}',
            color: ColorApp.white,
          )
        ],
      ),
    );
  }

  Obx historyPresensi(HomeController state) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount:
            state.dataPresensi.length <= 5 ? state.dataPresensi.length : 5,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final data = state.dataPresensi[index];
          return InkWell(
              onTap: () async {
                Get.put(PresensiController());
                await Future.delayed(const Duration(milliseconds: 600));
                await Get.toNamed(RouteName.detailPresensi, arguments: data.id);
                Get.delete<PresensiController>();
              },
              child: CardPresensi(data: data));
        },
      ),
    );
  }

  InkWell itemMenu(
      IconData icon, Color color, String title, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: color,
          ),
          spacer(2),
          TextC(text: title)
        ],
      ),
    );
  }
}
