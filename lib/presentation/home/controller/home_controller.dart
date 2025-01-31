import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/navigation/controller/navigation_controller.dart';

import '../../../domain/entity/attendance_entity.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../../service/time/time_service.dart';
import '../../location/controller/location_controller.dart';

class HomeController extends GetxController {
  final dep = Get.find<DependencyInjection>();
  final location = Get.find<LocationController>();
  final time = Get.find<TimeService>();
  final nav = Get.find<NavigationController>();

  final RxList<AttendanceEntity> dataPresensi = <AttendanceEntity>[].obs;

  RxBool isLoading = false.obs;
  final RxBool isError = false.obs;

  @override
  void onInit() {
    dataPresensi.clear();
    getPresensi();
    super.onInit();
  }

  Future<void> getPresensi() async {
    isLoading.value = true;
    final result = await dep.getPresensiUsecase.call(dep.user.value.id!, 1);
    isLoading.value = false;

    result.fold((e) {
      isError.value = true;
    }, (data) {
      dataPresensi.addAll(data.data);
    });
  }
}
