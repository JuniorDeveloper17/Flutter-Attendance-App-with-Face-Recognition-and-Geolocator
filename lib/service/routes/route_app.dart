import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/face_register/page/face_confirmation_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/face_register/page/face_register_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/izin/page/izin_add_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/izin/page/izin_detail_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/location/page/location_presensi_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/location/page/location_view_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/navigation/page/navigation_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/presensi/page/presensi_add_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/presensi/page/presensi_detail_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/presensi/page/presensi_konfirmation_page.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/profile/page/edit_profile_page.dart';
import 'package:presensi_universitas_bina_insan_app/service/binding/face_register_binding.dart';
import 'package:presensi_universitas_bina_insan_app/service/binding/navigation_binding.dart';
import 'package:presensi_universitas_bina_insan_app/service/binding/presensi_binding.dart';

import '../../presentation/location/page/location_page.dart';
import '../../presentation/location/page/location_permission_page.dart';
import '../../presentation/login/page/login_page.dart';
import '../binding/location_binding.dart';
import '../binding/login_binding.dart';
import 'route_name.dart';

class RouteApp {
  static final route = <GetPage>[
    GetPage(
      name: RouteName.login,
      binding: LoginBinding(),
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteName.location,
      binding: LocationBinding(),
      page: () => const LocationPage(),
    ),
    GetPage(
      name: RouteName.locationPermission,
      binding: LocationBinding(),
      page: () => const LocationPermissionPage(),
    ),
    GetPage(
      name: RouteName.locationView,
      page: () => const LocationViewPage(),
    ),
    GetPage(
        name: RouteName.home,
        binding: NavigationBinding(),
        page: () => const NavigationPage()),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: RouteName.addIzin,
      page: () => const IzinAddPage(),
    ),
    GetPage(
      name: RouteName.detailIzin,
      page: () => const IzinDetailPage(),
    ),
    GetPage(
      name: RouteName.faceRegister,
      binding: FaceRegisterBinding(),
      page: () => const FaceRegisterPage(),
    ),
    GetPage(
      name: RouteName.faceKonfirmation,
      page: () => const FaceConfirmationPage(),
    ),
    GetPage(
      name: RouteName.presensiAdd,
      binding: PresensiAddBinding(),
      page: () => const PresensiAddPage(),
    ),
    GetPage(
      name: RouteName.presensiConfirmation,
      page: () => const PresensiKonfirmationPage(),
    ),
    GetPage(
      name: RouteName.detailPresensi,
      page: () => const PresensiDetailPage(),
    ),
    GetPage(
      name: RouteName.locationPresensiView,
      page: () => const LocationPresensiPage(),
    )
  ];
}
