import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/service/routes/route_name.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/snackbar_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../domain/entity/izin_entity.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/picker/image_picker_service.dart';

class IzinController extends GetxController {
  final dep = Get.find<DependencyInjection>();

  final RxList<IzinEntity> dataIzin = <IzinEntity>[].obs;
  final Rx<IzinEntity> detailIzin = const IzinEntity().obs;

  final RxBool isLoading = false.obs;

  List<String> type = [
    'sakit',
    'izin',
    'lainya',
  ];

  final typeController = TextEditingController();
  final keterangan = TextEditingController();
  final RxString file = ''.obs;

//==>> function get izin

  final RxInt pages = 1.obs;
  final RxInt lastPage = 0.obs;
  final RxBool isError = false.obs;

  final RxBool hasMore = true.obs;
  final scrollController = ScrollController();

  Future<void> getIzin() async {
    isLoading.value = true;
    final result =
        await dep.getIzinUsecase.call(dep.user.value.id!, pages.value);
    isLoading.value = false;

    result.fold((e) {
      hasMore.value = false;
    }, (data) {
      lastPage.value = data.pagination.lastPage;
      if (pages.value == lastPage.value) {
        hasMore.value = false;
      }
      dataIzin.addAll(data.data);
      pages.value = pages.value + 1;
    });
  }

  Future<void> getDetailIzin(int izinId) async {
    detailIzin.value = const IzinEntity();
    isError.value = false;
    isLoading.value = true;
    final result = await dep.detailIzinUsecase.call(izinId);
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    result.fold((e) {
      errorSnacbar(e.message!);
      isError.value = true;
    }, (data) {
      isError.value = false;
      detailIzin.value = const IzinEntity();
      detailIzin.value = data;
    });
  }

  Future<void> hapusIzin() async {
    isLoading.value = true;
    final result = await dep.hapusIzinUsecase.call(detailIzin.value.id!);
    isLoading.value = false;
    result.fold((e) {
      errorSnacbar(e.message!);
    }, (data) {
      successSnacbar('Izin berhasil dibatalkan');
      dataIzin.removeWhere((item) => item.id == detailIzin.value.id);
      Get.offNamed(RouteName.home);
    });
  }

//==>> function add or update izin

  void addIzin() async {
    if (typeController.text == '' && keterangan.text == '') {
      errorSnacbar('keterangan tidak boleh kosong');
    } else {
      final data = IzinEntity(
          idKaryawan: dep.user.value.id,
          keterangan: typeController.text,
          keteranganLanjutan: keterangan.text,
          document: file.value);

      isLoading.value = true;
      final result = await dep.addIzinUsecase.call(data);
      isLoading.value = false;

      result.fold((e) {
        errorSnacbar('${e.message}');
      }, (data) {
        dataIzin.insert(0, data);
        typeController.clear();
        keterangan.clear();
        file.value = '';
        successSnacbar('pengajuan izin berhasil dilakukan');
      });
    }
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
                  text: 'Pilih sumber file',
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
                      file.value = path ?? '';
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
                      file.value = path ?? '';
                      Get.back();
                    },
                  ))
                ],
              )
            ],
          ),
        ));
  }

  @override
  void onInit() {
    getIzin();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getIzin();
      }
    });
    super.onInit();
  }
}
