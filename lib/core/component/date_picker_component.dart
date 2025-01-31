import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../theme/color_theme.dart';

class DatePickerComponent extends StatelessWidget {
  const DatePickerComponent({
    super.key,
    this.borderColor,
    this.focusBorderColor,
    this.fillColor,
    this.borderWidth,
    this.borderRadius,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  });

  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? fillColor;
  final int? borderWidth;
  final int? borderRadius;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      controller: controller,
      dateMask: 'yyyy MM dd',
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
      type: DateTimePickerType.date,
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
      selectableDayPredicate: (date) {
        return true;
      },
      onChanged: (value) {
        String date = DateFormat('yyyy MM dd').format(DateTime.parse(value));
        controller.text = date;
      },
    );
  }
}
