import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/presentation/api/page/api_page.dart';
import 'package:presensi_universitas_bina_insan_app/service/binding/api_binding.dart';
import 'core/theme/color_theme.dart';
import 'service/routes/route_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RouteApp.route,
      initialBinding: ApiBinding(),

      ///MainBinding(),

      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 600),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          scrolledUnderElevation: 0,
        ),
        scaffoldBackgroundColor: ColorApp.white,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primary),
        useMaterial3: true,
      ),
      home: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: ApiPage(),
      ),
    );
  }
}
