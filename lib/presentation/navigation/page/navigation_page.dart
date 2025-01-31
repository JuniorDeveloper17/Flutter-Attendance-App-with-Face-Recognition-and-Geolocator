import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../controller/navigation_controller.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<NavigationController>();
    return Scaffold(
        body: Obx(
          () => state.page.elementAt(state.pageIndex.value),
        ),
        bottomNavigationBar: Obx(() => AnimatedNotchBottomBar(
              notchBottomBarController: NotchBottomBarController(
                index: state.pageIndex.value,
              ),
              kBottomRadius: 20,
              shadowElevation: 3,
              kIconSize: 20,
              onTap: (value) => state.changePage(value),
              bottomBarItems: [
                navigationItem(
                  icon: MyIcon.home,
                  title: 'Home'.obs,
                ),
                navigationItem(
                  icon: MyIcon.datang,
                  title: 'Presensi'.obs,
                ),
                navigationItem(
                  icon: MyIcon.izin,
                  title: 'Izin'.obs,
                ),
                navigationItem(
                  icon: MyIcon.profile,
                  title: 'Profile'.obs,
                ),
              ],
            )));
  }
}

BottomBarItem navigationItem(
    {required IconData icon, required RxString title}) {
  return BottomBarItem(
    inActiveItem: Icon(
      icon,
      color: ColorApp.primary,
    ),
    activeItem: Icon(
      icon,
      color: ColorApp.warning,
    ),
    itemLabel: title.value,
  );
}
