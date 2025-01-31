import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../service/injection/dependency_injection.dart';

class LocationPresensiPage extends StatelessWidget {
  const LocationPresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments.toString().split(',');

    final dep = Get.find<DependencyInjection>();
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  double.parse(argument[0]),
                  double.parse(argument[1]),
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
                MarkerLayer(rotate: true, markers: [
                  Marker(
                      point: LatLng(
                        double.parse(argument[0]),
                        double.parse(argument[1]),
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
                            'Lokasi Masuk',
                            style: TextStyle(
                                color: ColorApp.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  argument.length == 4
                      ? Marker(
                          point: LatLng(
                            double.parse(argument[2]),
                            double.parse(argument[3]),
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
                                color: ColorApp.primary,
                                size: 30,
                              ),
                              Text(
                                'Lokasi Keluar',
                                style: TextStyle(
                                    color: ColorApp.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ))
                      : Marker(point: const LatLng(0, 0), child: spacer(0)),
               
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
                ])
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
    );
  }
}
