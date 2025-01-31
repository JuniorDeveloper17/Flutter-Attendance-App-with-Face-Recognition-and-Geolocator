import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    super.key,
    this.text,
    this.icon,
    this.shadowColor,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.size,
    required this.ontap,
  });

  final String? text;
  final Widget? icon;

  final Color? shadowColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  final int? borderRadius;
  final int? borderWidth;
  final int? elevation;

  final Size? size;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        elevation: elevation?.toDouble() ?? 2,
        shadowColor: shadowColor ?? ColorApp.secondary,
        overlayColor: ColorApp.white.withOpacity(0.5),
        backgroundColor: backgroundColor ?? ColorApp.warning,
        fixedSize: size ?? Size(Get.width, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 5),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth?.toDouble() ?? 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox(),
          AutoSizeText(
            text ?? '',
            style: textStyle ??
                GoogleFonts.outfit(
                  color: ColorApp.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
