import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_circle_component.dart';
import '../../../core/component/image_view_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/theme/color_theme.dart';

class PickedFileWidget extends StatelessWidget {
  const PickedFileWidget({super.key, required this.ontap, required this.image});

  final RxString image;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => InkWell(
                  onTap: () => image.value == ''
                      ? null
                      : Get.to(ImageViewComponent(url: image.value)),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: image.value == ''
                        ? BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          )
                        : BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(image.value)))),
                    child: image.value == ''
                        ? const Icon(
                            Icons.file_copy_outlined,
                            color: ColorApp.info,
                          )
                        : spacer(0),
                  ),
                ),
              ),
            ),
          ),
          ButtonCircleComponent(
            ontap: ontap,
            bgColor: ColorApp.info,
            widget: Obx(
              () => Icon(
                image.value == '' ? Icons.add : Icons.close,
                color: ColorApp.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
