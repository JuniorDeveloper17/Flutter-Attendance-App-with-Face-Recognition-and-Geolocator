import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'location_permission_model.dart';

abstract class LocationService {
  Future<LocationPermissionModel> checkPermission();
  Future<LocationPermission> requestPermission();
  Stream<ServiceStatus> streamLocationService();
  Stream<Position> streamPosition();
  Future requestLocationService();
  Future openAppSetting();
  String getDistance(
    double latIn,
    double longIn,
    double latOut,
    double longOut,
  );
  int cekDistance(
    double latIn,
    double longIn,
    double latOut,
    double longOut,
  );
  Future<Placemark> getPlacemark(double lat, double long);
}

class LocationServiceImpl extends LocationService {
  @override
  Future<LocationPermissionModel> checkPermission() async {
    try {
      final serviceEnable = await Geolocator.isLocationServiceEnabled();
      final aksesEnable = await Geolocator.checkPermission();
      return LocationPermissionModel(
        serviceEnable: serviceEnable,
        permissionEnable: aksesEnable != LocationPermission.denied &&
                aksesEnable != LocationPermission.deniedForever &&
                aksesEnable != LocationPermission.unableToDetermine
            ? true
            : false,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String getDistance(
      double latIn, double longIn, double latOut, double longOut) {
    try {
      double jarak = Geolocator.distanceBetween(latIn, longIn, latOut, longOut);
      if (jarak >= 1000) {
        double jarakKm = jarak / 1000;
        return '${jarakKm.toStringAsFixed(2)} km';
      } else {
        return '${jarak.toStringAsFixed(0)} m';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future openAppSetting() async {
    await Geolocator.openAppSettings();
  }

  @override
  Future requestLocationService() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  @override
  Stream<ServiceStatus> streamLocationService() {
    try {
      return Geolocator.getServiceStatusStream();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<Position> streamPosition() {
    try {
      final androidSetting = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 1),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "aplikasi sedang melacak lokasi anda",
          notificationTitle: "E-Presensi",
          enableWakeLock: true,
        ),
      );
      return Geolocator.getPositionStream(locationSettings: androidSetting);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  int cekDistance(double latIn, double longIn, double latOut, double longOut) {
    double jarak = Geolocator.distanceBetween(latIn, longIn, latOut, longOut);
    return jarak.toInt();
  }

  @override
  Future<Placemark> getPlacemark(double lat, double long) async {
    final place = await placemarkFromCoordinates(lat, long);
    return place.last;
  }
}
