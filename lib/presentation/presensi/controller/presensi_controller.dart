import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/dialog_component.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/attendance_entity.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/location/controller/location_controller.dart';
import '../../../core/component/snackbar_component.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/routes/route_name.dart';

class PresensiController extends GetxController {
  final dep = Get.find<DependencyInjection>();
  final location = Get.find<LocationController>();

  final RxList<AttendanceEntity> dataPresensi = <AttendanceEntity>[].obs;
  final Rx<AttendanceEntity> detailPresensi = const AttendanceEntity().obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getPresensi();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getPresensi();
      }
    });
    super.onInit();
  }

  final RxBool isError = false.obs;
  final RxInt pages = 1.obs;
  final RxInt lastPage = 0.obs;

  final RxBool hasMore = true.obs;
  final scrollController = ScrollController();

  Future<void> addPresensi() async {
    if (dep.user.value.faceId == null) {
      dialogInfo(
        confirm: () => Get.back(),
        subtitle:
            'Wajah anda belum terdaftar. Silahkan lakukan registrasi wajah terlebih dahulu dan coba kembali',
      );
    } else {
      if (dataPresensi.isNotEmpty) {
        final a = TimeFormatter().formatHMY(
          DateTime.parse(dataPresensi.first.createdAt!),
        );
        final b = TimeFormatter().formatHMY(DateTime.now());
        if (dataPresensi.first.durasiKerja != '' && a == b) {
          dialogInfo(
            confirm: () => Get.back(),
            title: 'PERINGATAN',
            subtitle:
                'Anda sudah melakukan presensi masuk dan presensi keluar hari ini. Lakukan presensi lagi di hari berikutnya',
          );
        } else {
          if (dep.user.value.status != 'Aktif') {
            dialogInfo(
              confirm: () => Get.back(),
              subtitle:
                  'Tidak dapat melakukan presensi karena status anda sedang tidak aktif',
            );
          } else {
            if (location.position.value.isMocked == true) {
              dialogInfo(
                confirm: () => Get.back(),
                title: 'FAKE LOCATION',
                subtitle:
                    'Anda terdeteksi memakai layanan lokasi palsu, harap gunakan lokasi asli anda dan coba kembali',
              );
            } else {
              Get.toNamed(RouteName.presensiAdd);
            }
          }
        }
      } else {
        Get.toNamed(RouteName.presensiAdd);
      }
    }
  }

  Future<void> getPresensi() async {
    isLoading.value = true;
    final result =
        await dep.getPresensiUsecase.call(dep.user.value.id!, pages.value);
    isLoading.value = false;

    result.fold((e) {
      hasMore.value = false;
    }, (data) {
      lastPage.value = data.pagination.lastPage;
      if (pages.value == lastPage.value) {
        hasMore.value = false;
      }
      dataPresensi.addAll(data.data);
      pages.value = pages.value + 1;
    });
  }

  Future<void> getDetailPresensi(int attendanceId) async {
    isError.value = false;
    isLoading.value = true;
    final result = await dep.detailPresensiUsecase.call(attendanceId);
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    result.fold((e) {
      errorSnacbar(e.message!);
      isError.value = true;
    }, (data) {
      isError.value = false;
      detailPresensi.value = const AttendanceEntity();
      detailPresensi.value = data;
    });
  }
}
