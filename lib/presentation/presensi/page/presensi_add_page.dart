import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/text_component.dart';
import 'package:presensi_universitas_bina_insan_app/core/utils/img.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/presensi/controller/presensi_add_controller.dart';
import 'package:presensi_universitas_bina_insan_app/service/routes/route_name.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/widget_camera_componnent.dart';
import '../../../core/theme/color_theme.dart';
import '../../../service/face/face_painter.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../location/controller/location_controller.dart';

class PresensiAddPage extends StatelessWidget {
  const PresensiAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<PresensiAddController>();
    final location = Get.find<LocationController>();
    final dep = Get.find<DependencyInjection>();

    return Scaffold(
      body: InkWell(
        onTap: () {
          if (state.isLoadingPresensi.isTrue) {
            state.kedipanMata.value = 1;
            state.isBusy.value = false;
            state.isLoadingPresensi.value = false;
          }
        },
        child: Obx(() => state.isCameraInitialized.isFalse
            ? LoadingComponent(isLoading: true.obs)
            : state.isLoadingPresensi.isTrue
                ? SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                            color: ColorApp.warning, strokeWidth: 2),
                        spacer(20),
                        const TextH1(text: 'Melakukan Validasi Data'),
                      ],
                    ),
                  )
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
                            child: SizedBox(child: buildPainter()),
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
                          Expanded(
                            child: spacer(0),
                          ),
                          cardLocation(dep, state, location),
                          spacer(50)
                        ],
                      ),
                      LoadingComponent(isLoading: state.isLoading)
                    ],
                  )),
      ),
    );
  }

  Padding cardLocation(DependencyInjection dep, PresensiAddController state,
      LocationController location) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Obx(
        () => Card(
          color: dep.user.value.wfa == true
              ? ColorApp.success.withOpacity(0.5)
              : state.statusRadius.isFalse
                  ? ColorApp.danger.withOpacity(0.2)
                  : ColorApp.primary.withOpacity(0.2),
          child: ListTile(
            onTap: () => Get.toNamed(RouteName.locationView),
            leading: Image.asset(
              Img.seLocation,
              width: 100,
            ),
            title: TextP(
              text: dep.user.value.wfa == true
                  ? 'Status WFA'
                  : state.statusRadiusLokasi.value,
              color: ColorApp.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPainter() {
    final state = Get.find<PresensiAddController>();

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
