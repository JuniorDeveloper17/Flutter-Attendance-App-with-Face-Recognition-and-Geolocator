import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/component/button_circle_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';
import '../../../service/injection/dependency_injection.dart';
import '../controller/location_controller.dart';

class LocationViewPage extends StatelessWidget {
  const LocationViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final location = Get.find<LocationController>();
    final dep = Get.find<DependencyInjection>();
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  location.position.value.latitude,
                  location.position.value.longitude,
                ),
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  maxNativeZoom: 19,
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                        point: LatLng(
                          double.parse(dep.office.value.latitude!),
                          double.parse(dep.office.value.longitude!),
                        ),
                        radius: dep.office.value.radius!.toDouble(),
                        useRadiusInMeter: true,
                        color: ColorApp.danger.withOpacity(0.4)),
                  ],
                ),
                MarkerLayer(
                  rotate: true,
                  markers: [
                    Marker(
                        point: LatLng(
                          location.position.value.latitude,
                          location.position.value.longitude,
                        ),
                        width: 150,
                        height: 80,
                        alignment: Alignment.center,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyIcon.location,
                              color: ColorApp.danger,
                              size: 30,
                            ),
                            Text(
                              'Anda',
                              style: TextStyle(
                                  color: ColorApp.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                    Marker(
                        point: LatLng(
                          double.parse(dep.office.value.latitude!),
                          double.parse(dep.office.value.longitude!),
                        ),
                        width: 150,
                        height: 80,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              MyIcon.location,
                              color: ColorApp.primary,
                              size: 30,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Office ${dep.office.value.nama}',
                              style: const TextStyle(
                                  color: ColorApp.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                ),
              ]),
          SizedBox(
            height: 100,
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const TextTitle(text: 'Map View'),
            ),
          )
        ],
      ),
      floatingActionButton: ButtonCircleComponent(
        ontap: () {
          final data = location.placemark!.value;
          Get.bottomSheet(Container(
            width: Get.width,
            decoration: const BoxDecoration(
                color: ColorApp.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                spacer(20),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 5,
                    width: Get.width / 3,
                    decoration: const BoxDecoration(color: ColorApp.warning),
                  ),
                ),
                spacer(20),
                ListTile(
                  leading: const Icon(
                    MyIcon.location,
                    color: ColorApp.info,
                  ),
                  title: const TextH2(text: 'Lokasi Anda'),
                  subtitle: TextP(
                    text:
                        '${data.country}, ${data.administrativeArea}, ${data.street}, ${data.subAdministrativeArea}, ${data.locality}, ${data.subLocality}, ${data.postalCode}',
                  ),
                ),
                ListTile(
                  leading: const Icon(MyIcon.wfa, color: ColorApp.info),
                  title: const TextH2(text: 'Status Jangkauan'),
                  subtitle: TextP(
                    text:
                        'Jarak lokasi anda dari lokasi office adalah ${dep.locationService.getDistance(location.position.value.latitude, location.position.value.longitude, double.parse(dep.office.value.latitude!), double.parse(dep.office.value.longitude!))}\n ',
                  ),
                ),
                Image.asset(
                  Img.map,
                  width: Get.width/1.5,
                )
              ],
            ),
          ));
        },
        widget: const Icon(Icons.info),
      ),
    );
  }
}
