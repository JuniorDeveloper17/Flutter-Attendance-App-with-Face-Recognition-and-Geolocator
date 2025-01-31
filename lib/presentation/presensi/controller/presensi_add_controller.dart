import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/dialog_component.dart';
import '../../../core/component/snackbar_component.dart';
import '../../../domain/entity/attendance_entity.dart';
import '../../../service/face/face_model.dart';
import '../../../service/face/face_service.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/routes/route_name.dart';
import '../../location/controller/location_controller.dart';
import 'presensi_controller.dart';

class PresensiAddController extends GetxController {
  final dep = Get.find<DependencyInjection>();
  final location = Get.find<LocationController>();
  final presensiController = Get.find<PresensiController>();

  late FaceService? faceService;
  late CameraController? cameraController;

  final CameraLensDirection camDir = CameraLensDirection.front;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isBusy = false.obs;

  RxList<FaceDetectionModel> faceDetection = <FaceDetectionModel>[].obs;
  Rx<FaceModel> faceEmbbeding = FaceModel().obs;
  Rx<double> lat = 0.0.obs;
  Rx<double> long = 0.0.obs;

  RxInt kedipanMata = 1.obs;
  RxString statusRadiusLokasi = ''.obs;
  RxBool statusRadius = false.obs;
  RxBool isLoadingPresensi = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    faceService = FaceService();
    setupCamera();
    super.onInit();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  void onTapScreen() {
    kedipanMata.value = 1;
    isBusy.value = false;
    isLoadingPresensi.value = false;
  }

  void setupCamera() async {
    final description = await availableCameras();
    cameraController = CameraController(
      description[1],
      ResolutionPreset.low,
      enableAudio: false,
      fps: 24,
    );

    await cameraController!.initialize();
    printInfo(info: '${cameraController!.value.isInitialized}');
    isCameraInitialized.value = cameraController!.value.isInitialized;
    streamCamera();
  }

  void streamCamera() async {
    if (isCameraInitialized.isFalse) {
      await Future.delayed(const Duration(seconds: 1));
      setupCamera();
    } else {
      cameraController!.startImageStream((image) async {
        statusRadiusLokasi.value = checkDistance();

        if (isBusy.isFalse) {
          try {
            isBusy.value = true;
            final inputImage =
                faceService?.ambilGambarMasukan(image, cameraController!);
            if (inputImage != null) {
              final face = await faceService!.faceDetectors(inputImage);
              final result = faceService?.deteksiWajah(image, face, camDir);
              faceDetection.clear();
              result != null ? faceDetection.add(result) : null;

              final mata1 = face.last.leftEyeOpenProbability;
              final mata2 = face.last.rightEyeOpenProbability;
              if (mata1! < 0.5 && mata2! < 0.5) {
                kedipanMata.value = kedipanMata.value + 1;
              }
              if (kedipanMata.value >= 2 && mata1 > 0.5 && mata2! > 0.5) {
                faceEmbbeding.value = await faceService!.extrakEmbedding(
                  result!.cropFace!,
                  result.faceRect!,
                );
                isLoadingPresensi.value = true;
                isBusy.value = true;
                validasiWajah(faceEmbbeding.value.embed!);
              } else {
                isBusy.value = false;
              }
            }
          } catch (e) {
            printInfo(info: e.toString());
            faceDetection.clear();
            isLoadingPresensi.isFalse
                ? isBusy.value = false
                : isBusy.value = true;
          }
        }
      });
    }
  }

  void validasiWajah(List<double> embedding) async {
    final List<double> embed = List.from(json.decode(dep.user.value.faceId!));
    final distance = await faceService?.validasiFace(embedding, embed);
    printInfo(
      info:
          'distance : ${distance?['distance']} status valid : ${distance?['valid']}',
    );
    if (distance!['valid'] == false) {
      dialogInfo(
          confirm: () {
            kedipanMata.value = 1;
            isBusy.value = false;
            isLoadingPresensi.value = false;
            Get.back();
          },
          title: 'WAJAH TIDAK VALID',
          buttonTitle: 'Kembali',
          subtitle:
              'Wajah anda tidak valid. Silahkan lakukan presensi dengan wajah yang valid');
    } else {
      final wfa = dep.user.value.wfa;
      wfa == false ? validasiLokasi() : stopStreamKamera();
    }
  }

  void validasiLokasi() async {
    if (statusRadius.isFalse) {
      dialogInfo(
          confirm: () {
            kedipanMata.value = 1;
            isBusy.value = false;
            isLoadingPresensi.value = false;
            Get.back();
          },
          title: 'LOKASI TIDAK VALID',
          subtitle:
              'Lokasi anda berada diluar jarak radius presensi. Tidak bisa melanjutkan aksi',
          buttonTitle: 'Kembali');
    } else {
      stopStreamKamera();
    }
  }

  void stopStreamKamera() async {
    kedipanMata.value = 1;
    statusRadius.value = false;
    statusRadiusLokasi.value = '';
    await addPresensi();
  }

  Future addPresensi() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/absensi.png';
    final file = File(path);
    final bytes = Uint8List.fromList(
      img.encodePng(
        faceDetection.last.cropFace!,
      ),
    );
    await file.writeAsBytes(bytes);
    final AttendanceEntity data;

    final existingPresensi = presensiController.dataPresensi.any((e) {
      return DateTime.parse(e.createdAt!).year == DateTime.now().year &&
          DateTime.parse(e.createdAt!).month == DateTime.now().month &&
          DateTime.parse(e.createdAt!).day == DateTime.now().day;
    });

    if (existingPresensi) {
      data = AttendanceEntity(
        idKaryawan: '${dep.user.value.id}',
        checkoutLocation: '${lat.value}, ${long.value}',
        checkoutImage: file.path,
        idDevice: dep.idDevice.value,
      );
    } else {
      data = AttendanceEntity(
        idKaryawan: '${dep.user.value.id}',
        checkinLocation: '${lat.value}, ${long.value}',
        checkinImage: file.path,
        office: '${dep.office.value.id}',
        shift: '${dep.shift.value.id}',
        idDevice: dep.idDevice.value,
      );
    }

    final result = await dep.presensiAddUsecase.call(data);
    isLoadingPresensi.value = false;

    result.fold((e) async {
      errorSnacbar(e.message!);
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(RouteName.home);
    }, (data) {
      lat.value = 0.0;
      long.value = 0.0;

      final existingPresensi = presensiController.dataPresensi.indexWhere(
        (e) {
          return DateTime.parse(e.createdAt!).year == DateTime.now().year &&
              DateTime.parse(e.createdAt!).month == DateTime.now().month &&
              DateTime.parse(e.createdAt!).day == DateTime.now().day;
        },
      );

      if (existingPresensi != -1) {
        presensiController.dataPresensi[existingPresensi] = data;
      } else {
        presensiController.dataPresensi.insert(0, data);
      }

      Get.offNamed(RouteName.presensiConfirmation);
    });
  }

  String checkDistance() {
    lat.value = location.position.value.latitude;
    long.value = location.position.value.longitude;
    final radiusOffice = dep.office.value.radius;
    final value = dep.locationService.cekDistance(
        double.parse(dep.office.value.latitude!),
        double.parse(dep.office.value.longitude!),
        location.position.value.latitude,
        location.position.value.longitude);

    statusRadius.value = radiusOffice! >= value ? true : false;
    return radiusOffice >= value
        ? 'Status anda dalam radius presensi dengan jarak $value Meter'
        : 'Status anda diluar radius presensi dengan jarak $value Meter';
  }
}
