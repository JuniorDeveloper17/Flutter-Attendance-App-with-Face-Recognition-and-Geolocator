import 'package:flutter/material.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';

class ButtonCircleComponent extends StatelessWidget {
  const ButtonCircleComponent({
    super.key,
    this.widget,
    this.elevation,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    required this.ontap,
  });
  final Widget? widget;
  final int? elevation;
  final Color? bgColor;
  final Color? borderColor;
  final int? borderWidth;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ontap,
      elevation: elevation?.toDouble(),
      backgroundColor: bgColor ?? ColorApp.warning,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(400),
        side: BorderSide(
          color: borderColor ?? ColorApp.white,
          width: borderWidth?.toDouble() ?? 2,
        ),
      ),
      child: widget,
    );
  }
}
