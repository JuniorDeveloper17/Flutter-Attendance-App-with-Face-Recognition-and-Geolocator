import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';
import '../../home/page/home_page.dart';
import '../../izin/controller/izin_controller.dart';
import '../../izin/page/izin_page.dart';
import '../../presensi/controller/presensi_controller.dart';
import '../../presensi/page/presensi_page.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/page/profile_page.dart';

class NavigationController extends GetxController {
  final RxInt pageIndex = 0.obs;

  final RxList page = [
    const HomePage(),
    const PresensiPage(),
    const IzinPage(),
    const ProfilePage(),
  ].obs;

  void changePage(int page) async {
    switch (page) {
      case 0:
        await deletePage();
        Get.put(HomeController());
        pageIndex.value = page;
        break;
      case 1:
        await deletePage();
        Get.put(PresensiController());
        pageIndex.value = page;
        break;
      case 2:
        await deletePage();
        Get.put(IzinController());
        pageIndex.value = page;
        break;
      case 3:
        await deletePage();
        Get.put(ProfileController());
        pageIndex.value = page;
        break;
      default:
    }
  }

  Future deletePage() async {
    switch (pageIndex.value) {
      case 0:
        Get.delete<HomeController>();
        break;
      case 1:
        Get.delete<PresensiController>();
        break;
      case 2:
        Get.delete<IzinController>();
        break;
      case 3:
        Get.delete<ProfileController>();
        break;
      default:
    }
  }
}
