import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/service/injection/dependency_injection.dart';
import '../../../core/component/button_circle_component.dart';
import '../../../core/component/image_view_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.image,
    required this.ontap,
  });

  final RxString image;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    final dep = Get.find<DependencyInjection>();
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: ColorApp.white),
          ),
          child: InkWell(
            onTap: () => image.value != ''
                ? Get.to(ImageViewComponent(
                    url: image.contains('assets')
                        ? dep.user.value.jenisKelamin == 'Laki Laki'
                            ? Img.l
                            : Img.p
                        : image.value))
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: image.value,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                        color: ColorApp.secondary,
                        strokeWidth: 5,
                        value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    dep.user.value.jenisKelamin == 'Laki Laki'
                        ? Image.asset(
                            Img.l,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            Img.p,
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
        ),
        ButtonCircleComponent(
          ontap: ontap,
          borderWidth: 3,
          elevation: 0,
          widget: const Icon(
            MyIcon.edit,
            color: ColorApp.white,
          ),
        )
      ],
    );
  }
}

class ProfileEditWidget extends StatelessWidget {
  const ProfileEditWidget({
    super.key,
    required this.image,
    required this.ontap,
  });

  final RxString image;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: ColorApp.warning),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                File(image.value),
                fit: BoxFit.cover,
              )),
        ),
        image.value == ''
            ? ButtonCircleComponent(
                ontap: ontap,
                borderWidth: 3,
                elevation: 0,
                widget: const Icon(
                  MyIcon.tambahFoto,
                  color: ColorApp.white,
                ),
              )
            : ButtonCircleComponent(
                ontap: ontap,
                borderWidth: 3,
                elevation: 0,
                widget: const Icon(
                  MyIcon.close,
                  color: ColorApp.white,
                ),
              )
      ],
    );
  }
}
