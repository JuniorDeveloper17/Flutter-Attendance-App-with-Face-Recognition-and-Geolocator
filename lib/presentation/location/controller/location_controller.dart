import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/snackbar_component.dart';
import 'package:presensi_universitas_bina_insan_app/service/routes/route_name.dart';
import '../../../domain/entity/location_entity.dart';
import '../../../service/injection/dependency_injection.dart';
import '../../login/controller/login_controller.dart';

class LocationController extends GetxController {
  final dep = Get.find<DependencyInjection>();
  final RxBool isDeniedForever = false.obs;
  final RxBool permissionStatus = false.obs;
  final RxBool serviceLocatorEnable = false.obs;
  final Rx<Placemark>? placemark = const Placemark().obs;
  final Rx<Position> position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  ).obs;

  late StreamSubscription<ServiceStatus>? streamServiceStatus;
  late StreamSubscription<Position>? streamPositionSubscription;

  void requestPermission() async {
    final status = await dep.locationService.checkPermission();
    if (status.permissionEnable == false) {
      if (isDeniedForever.isFalse) {
        final status = await dep.locationService.requestPermission();
        if (status == LocationPermission.denied) {
          errorSnacbar('izinkan aplikasi untuk mengakses lokasi anda');
        }
        if (status == LocationPermission.deniedForever) {
          errorSnacbar('izin lokasi telah ditolak.');
          isDeniedForever.value = true;
        }
        if (status == LocationPermission.always ||
            status == LocationPermission.whileInUse) {
          printInfo(info: 'lanjutkan ke pengecekan status login');
          final login = Get.put(LoginController());
          login.cekLoginStatus();
        }
      } else {
        await dep.locationService.openAppSetting();
      }
    } else {
      printInfo(info: 'lanjutkan ke pengecekan status login');
      final login = Get.put(LoginController());
      login.cekLoginStatus();
    }
  }

  void checkLocationPermission() async {
    final permission = await dep.locationService.checkPermission();
    permissionStatus.value = permission.permissionEnable ?? false;
    serviceLocatorEnable.value = permission.serviceEnable ?? false;

    startStreamServiceStatus();
    if (permissionStatus.isTrue && serviceLocatorEnable.isTrue) {
      startStreamLocation();
      printInfo(info: 'pergi ke home');
      Get.offAllNamed(RouteName.home);
    } else {
      Get.offNamed(RouteName.location);
    }
  }

  void startStreamServiceStatus() async {
    streamServiceStatus =
        dep.locationService.streamLocationService().listen((data) async {

      if (position.value.isMocked != true) {
        switch (data) {
          case ServiceStatus.disabled:
            serviceLocatorEnable.value = false;
            streamPositionSubscription?.cancel();
            Get.offNamed(RouteName.location);
            break;
          case ServiceStatus.enabled:
            serviceLocatorEnable.value = true;
            startStreamLocation();
            dep.user.value.id != null
                ? Get.offNamed(RouteName.home)
                : Get.offNamed(RouteName.login);
            break;
          default:
        }
      }
    });
  }

  void startStreamLocation() async {
    if (permissionStatus.isTrue && serviceLocatorEnable.isTrue) {
      streamPositionSubscription =
          dep.locationService.streamPosition().listen((value) async {
        if (position.value.latitude == 0 ||
            position.value.latitude != value.latitude ||
            position.value.longitude != value.longitude) {
          position.value = value;
          await convertToPlacemark(value);
          position.value.isMocked == true ? null : sendLocation(value);
        }
      });
    }
  }

  Future convertToPlacemark(Position position) async {
    final result =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    placemark?.value = result[0];
  }

  void sendLocation(Position position) async {
    final userId = dep.user.value.id;
    final office = dep.office.value;
    if (userId != null) {
      final distance = dep.locationService.cekDistance(
        double.parse(office.latitude!),
        double.parse(office.longitude!),
        position.latitude,
        position.longitude,
      );
      final result = await dep.locationSenUsecase.call(
        LocationEntity(
          idKaryawan: userId,
          idDevice: dep.idDevice.value,
          distance: '$distance',
          latitude: '${position.latitude}',
          longitude: '${position.longitude}',
          location:
              '${placemark?.value.administrativeArea}, ${placemark?.value.subLocality}',
        ),
      );

      result.fold((e) {
        printError(info: e.message!);
      }, (data) {
        printInfo(info: '$data');
      });
    }
  }

  Future requestServiceLocator() async {
    try {
      await dep.locationService.requestLocationService();
    } catch (e) {
      errorSnacbar(e.toString());
    }
  }
}
