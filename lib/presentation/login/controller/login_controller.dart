import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/snackbar_component.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/routes/route_name.dart';

class LoginController extends GetxController {
  final dep = Get.find<DependencyInjection>();
  final isLoading = false.obs;
  final isStatusLogin = false.obs;

  // form state
  final emails = TextEditingController();
  final passwords = TextEditingController();
  final obsecureText = true.obs;
  final saveLoginStatus = false.obs;

  void cekLoginStatus() async {
    final data = await dep.getLoginStatusUsecase.call();
    data.fold((e) {
      isStatusLogin.isFalse ? null : errorSnacbar(e.message!);
      isStatusLogin.value = false;
      Get.offNamed(RouteName.login);
    }, (data) {
      isStatusLogin.value = true;
      login(data.email ?? 'null', data.password ?? 'null');
    });
  }

  void login(String email, String password) async {
    if (email == '' && password == '') {
      errorSnacbar('email dan password tidak boleh kosong');
    }
    if (email != '' && password != '') {
      isLoading.value = true;
      final data = await dep.loginUsecase.call(
        UserEntity(
          email: email,
          password: password,
          idDevice: dep.idDevice.value,
        ),
      );

      data.fold((e) {
        errorSnacbar(e.message!);
        isLoading.value = false;
        Get.offAllNamed(RouteName.login);
      }, (data) async {
        printInfo(info: '${data.password}');
        dep.user.value = data;

        await Future.wait([
          getOffice(data.idOffice!),
          getShift(data.idShift!),
        ]);

        if (saveLoginStatus.isTrue) {
          await saveLogin(data);
        }

        isLoading.value = false;
        emails.clear();
        passwords.clear();
        Get.offAllNamed(RouteName.location);
      });
    }
  }

  Future saveLogin(UserEntity param) async {
    final data = await dep.saveLoginStatusUsecase.call(param);

    data.fold((e) {
      printError(info: e.message!);
    }, (data) {
      printInfo(info: 'status login berhasil disimpan');
    });
  }

  Future getOffice(int id) async {
    final data = await dep.officeGetUsecase.call(id);

    data.fold((e) {
      printError(info: e.message!);
    }, (data) {
      printInfo(info: '$data');
      dep.office.value = data;
    });
  }

  Future getShift(int id) async {
    final data = await dep.shiftGetUsecase.call(id);

    data.fold((e) {
      printError(info: e.message!);
    }, (data) {
      printInfo(info: '$data');
      dep.shift.value = data;
    });
  }
}
