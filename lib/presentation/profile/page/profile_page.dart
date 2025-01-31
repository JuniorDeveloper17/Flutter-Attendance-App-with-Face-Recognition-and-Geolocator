import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/dialog_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/routes/route_name.dart';
import '../controller/profile_controller.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dep = Get.find<DependencyInjection>();
    final profile = Get.find<ProfileController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 380,
              width: Get.width,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    Img.bgHome,
                    width: Get.width,
                    fit: BoxFit.fill,
                    color: const Color.fromARGB(255, 4, 29, 197),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      spacer(40),
                      const TextTitle(
                        text: 'Profile',
                        color: ColorApp.white,
                      ),
                      spacer(30),
                      ProfileWidget(
                        image: dep.user.value.foto?.obs ?? 'assets'.obs,
                        ontap: () => Get.toNamed(RouteName.editProfile),
                      ),
                      spacer(30),
                      TextH1(
                        text: '${dep.user.value.nama}',
                        color: ColorApp.white,
                      ),
                      spacer(10),
                      TextP(
                        text: '${dep.user.value.email}',
                        color: ColorApp.white,
                      ),
                      spacer(20)
                    ],
                  )
                ],
              ),
            ),
            spacer(20),
            widgetItemProfile(dep),
            spacer(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ButtonComponent(
                ontap: () => dialogKonfirm(
                    cancel: () => Get.back(),
                    confirm: () => profile.logout(),
                    subtitle: 'apakah anda yakin ingin melakukan logout?'),
                backgroundColor: ColorApp.danger,
                text: 'Logout',
              ),
            )
          ],
        ),
      ),
    );
  }
}

Padding widgetItemProfile(DependencyInjection dep) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            MyIcon.wfa,
            color: ColorApp.info,
            size: 23,
          ),
          title: const TextH2(text: 'Type Karyawan'),
          subtitle: TextP(
            text: dep.user.value.wfa == true
                ? 'WFA (Work From Anywhere)'
                : 'Onsite',
          ),
          trailing: InkWell(
            onTap: () => dialogInfo(
              confirm: () => Get.back(),
              title: dep.user.value.wfa == true ? 'WFA' : 'ONSITE',
              subtitle: dep.user.value.wfa == true
                  ? 'Anda adalah karyawan dengan tipe WFA. Dimana anda bisa melakukan kegiatan presensi diluar radius lokasi office anda'
                  : 'Anda adalah karyawan dengan tipe Onsite. Dimana anda harus berada dalam radius office untuk dapat melakukan presensi',
            ),
            child: const Icon(
              MyIcon.info,
              color: ColorApp.secondary,
              size: 20,
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              width: 2,
              color: ColorApp.secondary.withOpacity(0.3),
            ),
          ),
        ),
        spacer(20),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            dep.user.value.status == 'Aktif'
                ? MyIcon.karyawanAktif
                : MyIcon.karyawanNoAktif,
            color: ColorApp.info,
            size: 23,
          ),
          title: const TextH2(text: 'Status Karyawan'),
          subtitle: TextP(
            text: dep.user.value.status ?? '',
          ),
          trailing: InkWell(
            onTap: () => dialogInfo(
              confirm: () => Get.back(),
              title: dep.user.value.status == 'Aktif' ? 'AKTIF' : 'TIDAK AKTIF',
              subtitle: dep.user.value.status == 'Aktif'
                  ? 'Status anda adalah karyawan aktif, dimana tidak sedang melakukan izin atau berada dalam cuti'
                  : 'Status anda adalah karyawan tidak aktif, dimana anda sekarang sedang melakukan izin atau sedang cuti',
            ),
            child: const Icon(
              MyIcon.info,
              color: ColorApp.secondary,
              size: 20,
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              width: 2,
              color: ColorApp.secondary.withOpacity(0.3),
            ),
          ),
        ),
        spacer(20),
        ListTile(
          onTap: () => Get.toNamed(RouteName.locationView),
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            MyIcon.apartment,
            color: ColorApp.info,
            size: 25,
          ),
          title: const TextH2(text: 'Office'),
          subtitle: TextP(
            text:
                '${dep.office.value.nama}, Radius Presensi ${dep.office.value.radius} Meter\n${dep.shift.value.nama} ${dep.shift.value.waktuMasuk}-${dep.shift.value.waktuKeluar}',
          ),
          trailing: InkWell(
            onTap: () => dialogInfo(
              confirm: () => Get.back(),
              title: 'OFFICE',
              subtitle:
                  'Office anda adalah ${dep.office.value.nama}, dengan radius presensi ${dep.office.value.radius} Meter. ${dep.shift.value.nama}, masuk pada jam ${dep.shift.value.waktuMasuk} dan keluar pada jam ${dep.shift.value.waktuKeluar}',
            ),
            child: const Icon(
              MyIcon.info,
              color: ColorApp.secondary,
              size: 20,
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              width: 2,
              color: ColorApp.secondary.withOpacity(0.3),
            ),
          ),
        ),
      ],
    ),
  );
}
