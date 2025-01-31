import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/snackbar_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../domain/entity/office_entity.dart';
import '../../../domain/entity/shift_entity.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/picker/image_picker_service.dart';
import '../../../service/routes/route_name.dart';
import '../../location/controller/location_controller.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;

  final dep = Get.find<DependencyInjection>();
  final location = Get.find<LocationController>();

  final alamat = TextEditingController();
  final noTelp = TextEditingController();
  final password = TextEditingController();
  final newPassword = TextEditingController();
  final tanggalLahir = TextEditingController();
  final jk = TextEditingController();

  final RxString image = ''.obs;

  void updatePassword() async {
    if (password.text == '' && newPassword.text == '') {
      errorSnacbar('lengkapi semua form dan coba lagi');
    } else {
      isLoading.value = true;
      final result = await dep.updatePaswordUserUsecase.call(
        dep.user.value.id!,
        password.text,
        newPassword.text,
      );
      isLoading.value = false;
      result.fold((e) {
        errorSnacbar(e.message!);
      }, (data) async {
        dep.user.value = data;
        await dep.saveLoginStatusUsecase.call(data);
        password.clear();
        newPassword.clear();
        successSnacbar('password anda berhasil di perbarui');
        await Future.delayed(const Duration(seconds: 3));
      });
    }
  }

  void updateProfile() async {
    final data = UserEntity(
      id: dep.user.value.id,
      alamat: alamat.text == dep.user.value.alamat ? '' : alamat.text,
      noTelp: noTelp.text == dep.user.value.noTelp ? '' : noTelp.text,
      tanggalLahir: tanggalLahir.text == dep.user.value.tanggalLahir
          ? ''
          : tanggalLahir.text,
      foto: image.value,
    );
    isLoading.value = true;
    final result = await dep.updateUserUsecase.call(data);
    isLoading.value = false;
    result.fold((e) {
      errorSnacbar(e.message ?? '');
    }, (data) {
      dep.user.value = data;
      successSnacbar('profile anda berhasil diperbarui');
    });
  }

  void getImage() async {
    Get.bottomSheet(
        backgroundColor: ColorApp.white,
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              SizedBox(width: Get.width),
              const ListTile(
                leading: Icon(MyIcon.folder),
                contentPadding: EdgeInsets.zero,
                title: TextH1(
                  text: 'Pilih sumber foto',
                ),
              ),
              spacer(10),
              Row(
                children: [
                  Expanded(
                      child: ButtonComponent(
                    icon: const Icon(
                      Icons.photo_camera_rounded,
                      color: ColorApp.white,
                    ),
                    text: '  Kamera',
                    ontap: () async {
                      final path =
                          await ImagePickerService().pickImageFormKamera();
                      image.value = path ?? '';
                      Get.back();
                    },
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ButtonComponent(
                    icon: const Icon(
                      Icons.image_search_rounded,
                      color: ColorApp.white,
                    ),
                    text: '  Galeri',
                    ontap: () async {
                      final path =
                          await ImagePickerService().picImageFormGalery();
                      image.value = path ?? '';
                      Get.back();
                    },
                  ))
                ],
              )
            ],
          ),
        ));
  }

  void logout() async {
    final data = await dep.deleteLoginStatus.call();
    data.fold((e) {
      errorSnacbar(e.message ?? '');
    }, (data) async {
      dep.user.value = const UserEntity();
      dep.office.value = const OfficeEntity();
      dep.shift.value = const ShiftEntity();
      await location.streamServiceStatus?.cancel();
      await location.streamPositionSubscription?.cancel();
      Get.offAllNamed(RouteName.login);
    });
  }
}
