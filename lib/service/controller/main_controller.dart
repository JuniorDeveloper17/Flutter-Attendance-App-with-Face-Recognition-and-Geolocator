import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/login/controller/login_controller.dart';
import 'package:presensi_universitas_bina_insan_app/service/injection/dependency_injection.dart';
import 'package:presensi_universitas_bina_insan_app/service/routes/route_name.dart';

class MainController extends GetxController {
  final dep = Get.find<DependencyInjection>();

  @override
  void onInit() {
    cekPermissionLocation();
    super.onInit();
  }

  // memastikan bahwa user sudah memberikan izin untuk akses lokasi
  void cekPermissionLocation() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final permission = await dep.locationService.checkPermission();
      if (permission.permissionEnable == false) {
        printInfo(info: 'pergi ke halaman lokasi permission');
        Get.offAllNamed(RouteName.locationPermission);
      } else {
        printInfo(info: 'periksa status login');
        final login = Get.put(LoginController());
        login.cekLoginStatus();
      }
    });
  }
}
