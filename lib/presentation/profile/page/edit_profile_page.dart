import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/date_picker_component.dart';
import '../../../core/component/form_component.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../service/injection/dependency_injection.dart';
import '../controller/profile_controller.dart';
import '../widget/profile_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dep = Get.find<DependencyInjection>();
    final state = Get.find<ProfileController>();

    state.alamat.text = dep.user.value.alamat ?? '';
    state.noTelp.text = dep.user.value.noTelp ?? '';
    state.tanggalLahir.text = dep.user.value.tanggalLahir ?? '';
    state.jk.text = dep.user.value.jenisKelamin ?? '';

    state.image.value = '';

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const TextTitle(text: 'Edit Profile'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Center(
                  child: Obx(
                    () => state.image.value == ''
                        ? ProfileWidget(
                            image: dep.user.value.foto?.obs ?? 'assets'.obs,
                            ontap: () => state.getImage(),
                          )
                        : ProfileEditWidget(
                            image: state.image,
                            ontap: () => state.image.value = '',
                          ),
                  ),
                ),
                spacer(20),
                TextH1(
                  text: '${dep.user.value.nama}',
                  color: ColorApp.black,
                ),
                spacer(10),
                TextP(
                  text: '${dep.user.value.email}',
                  color: ColorApp.secondary,
                ),
                spacer(20),
                const Row(
                  children: [
                    Icon(MyIcon.phone, size: 15),
                    SizedBox(width: 10),
                    TextP(text: 'Nomor ponsel'),
                  ],
                ),
                spacer(5),
                FormComponent(
                  controller: state.noTelp,
                  hint: 'nomor tlp',
                ),
                spacer(10),
                const Row(
                  children: [
                    Icon(MyIcon.map, size: 15),
                    SizedBox(width: 10),
                    TextP(text: 'Alamat'),
                  ],
                ),
                spacer(5),
                FormComponent(
                  controller: state.alamat,
                  hint: 'alamat',
                  maxLines: 5,
                ),
                spacer(10),
                const Row(
                  children: [
                    Icon(MyIcon.izin, size: 15),
                    SizedBox(width: 10),
                    TextP(text: 'Tanggal lahir'),
                  ],
                ),
                spacer(5),
                DatePickerComponent(controller: state.tanggalLahir),
                spacer(10),
                Row(
                  children: [
                    Icon(
                        state.jk.text == 'Laki Laki'
                            ? Icons.male
                            : Icons.female,
                        size: 15),
                    const SizedBox(width: 10),
                    const TextP(text: 'Jenis Kelamin'),
                  ],
                ),
                spacer(5),
                FormComponent(
                  controller: state.jk,
                  hint: 'jenis Kelamin',
                  readOnly: true,
                ),
                spacer(20),
                ButtonComponent(
                  ontap: () => state.updateProfile(),
                  text: 'Simpan',
                ),
                spacer(10),
                ButtonComponent(
                  ontap: () => Get.bottomSheet(ubahPassword(state)),
                  text: 'Ubah Password',
                  backgroundColor: ColorApp.danger,
                )
              ],
            ),
          ),
        ),
        LoadingComponent(isLoading: state.isLoading)
      ],
    );
  }

  Container ubahPassword(ProfileController state) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: ColorApp.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(MyIcon.password, size: 20, color: ColorApp.danger),
              SizedBox(width: 10),
              TextH2(
                text: 'Ubah Password',
                color: ColorApp.danger,
              ),
            ],
          ),
          spacer(15),
          FormComponent(
            controller: state.password,
            hint: 'Masukan Password Lama',
          ),
          spacer(5),
          FormComponent(
            controller: state.newPassword,
            hint: 'Masukan Password Baru',
          ),
          spacer(10),
          ButtonComponent(
            ontap: () => state.updatePassword(),
            text: 'Simpan',
          ),
        ],
      ),
    );
  }
}
