import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/loading_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/widget_camera_componnent.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/face_register/controller/face_register_controller.dart';

import '../../../service/face/face_painter.dart';

class FaceRegisterPage extends StatelessWidget {
  const FaceRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<FaceRegisterController>();
    return Scaffold(
      body: Obx(() => state.isCameraInitialized.isFalse
          ? LoadingComponent(isLoading: true.obs)
          : Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width *
                          state.cameraController!.value.aspectRatio,
                      child: CameraPreview(
                        state.cameraController!,
                        child: SizedBox(
                         
                          width: Get.width,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                 height: Get.height,
                 width: Get.width,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width *
                          state.cameraController!.value.aspectRatio,
                      child: SizedBox(
                        
                          child: buildPainter()),
                    ),
                  ),
                ),
                Column(
                  children: [
                    spacer(50),
                    Obx(() => state.faceDetection.isEmpty
                        ? wajahTidakTerdeteksi()
                        : verifyKedipanMata()),
                    spacer(10),
                    Expanded(child: spacer(0))
                  ],
                )
              ],
            )),
    );
  }

  Widget buildPainter() {
    final state = Get.find<FaceRegisterController>();

    if (state.faceDetection.isEmpty || state.isCameraInitialized.isFalse) {
      return const SizedBox();
    }
    final Size imageSize = Size(
      state.cameraController!.value.previewSize!.height,
      state.cameraController!.value.previewSize!.width,
    );
    CustomPainter painter =
        FacePainter(imageSize, state.faceDetection, state.camDir);
    return CustomPaint(
      painter: painter,
    );
  }
}
