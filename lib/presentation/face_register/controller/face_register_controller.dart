import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/snackbar_component.dart';
import 'package:presensi_universitas_bina_insan_app/domain/entity/user_entity.dart';
import 'package:presensi_universitas_bina_insan_app/service/injection/dependency_injection.dart';
import 'package:presensi_universitas_bina_insan_app/service/routes/route_name.dart';

import '../../../service/face/face_model.dart';
import '../../../service/face/face_service.dart';

class FaceRegisterController extends GetxController {
  final dep = Get.find<DependencyInjection>();

  late CameraController? cameraController;
  late FaceService? faceService;
  final CameraLensDirection camDir = CameraLensDirection.front;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isBusy = false.obs;

  RxList<FaceDetectionModel> faceDetection = <FaceDetectionModel>[].obs;
  Rx<FaceModel> faceEmbbeding = FaceModel().obs;

  RxInt kedipanMata = 1.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    faceService = FaceService();
    setupCamera();
    super.onInit();
  }

  @override
  void onClose() {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    super.onClose();
  }

  void saveEmbedding() async {
    isLoading.value = true;
    final embed = json.encode(faceEmbbeding.value.embed);
    final data = UserEntity(id: dep.user.value.id, faceId: embed);
    final result = await dep.updateUserUsecase.call(data);
    isLoading.value = false;
    result.fold((e) {
      errorSnacbar(e.message!);
    }, (data) async {
      await dep.saveLoginStatusUsecase.call(data);
      dep.user.value = data;
      successSnacbar('berhasil mendaftarkan wajah anda');
      Get.offAllNamed(RouteName.home);
    });
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
    if (isCameraInitialized.isTrue) {
      cameraController!.startImageStream((image) async {
        if (!isBusy.value) {
          isBusy.value = true;
          try {
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
              if (kedipanMata.value == 2) {
                faceEmbbeding.value = await faceService!.extrakEmbedding(
                  result!.cropFace!,
                  result.faceRect!,
                );
                stopStreamCamera();
              }
            }
          } catch (e) {
            faceDetection.clear();
            isBusy.value = false;
          }
          isBusy.value = false;
        }
      });
    } else {
      await Future.delayed(const Duration(seconds: 1));
      setupCamera();
    }
  }

  void stopStreamCamera() async {
    kedipanMata.value = 1;
    await Future.delayed(const Duration(milliseconds: 800));
    cameraController?.stopImageStream();
    Get.toNamed(
      RouteName.faceKonfirmation,
      arguments: faceDetection.last.cropFace,
    );
  }
}
