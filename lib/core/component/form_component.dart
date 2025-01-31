import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';

class FormComponent extends StatelessWidget {
  const FormComponent(
      {super.key,
      this.borderColor,
      this.focusBorderColor,
      this.fillColor,
      this.borderWidth,
      this.borderRadius,
      this.maxLines,
      this.obsecure,
      this.type,
      this.readOnly,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      this.textStyle});

  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? fillColor;
  final int? borderWidth;
  final int? borderRadius;
  final int? maxLines;

  final bool? obsecure;
  final bool? readOnly;
  final String? hint;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final TextInputType? type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle ??
          GoogleFonts.outfit(
            color: ColorApp.black,
            fontSize: 14,
          ),
      readOnly: readOnly ?? false,
      keyboardType: type,
      obscureText: obsecure ?? false,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        enabled: true,
        filled: true,
        fillColor: fillColor ?? Colors.grey[200],
        hintText: hint ?? '',
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: GoogleFonts.outfit(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 5),
          borderSide: BorderSide(
            width: borderWidth?.toDouble() ?? 1,
            color: focusBorderColor ?? ColorApp.info,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 5),
          borderSide: BorderSide(
              width: borderWidth?.toDouble() ?? 1,
              color: borderColor ?? Colors.transparent),
        ),
      ),
    );
  }
}
