import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class DropdownComponent extends StatelessWidget {
  const DropdownComponent(
      {super.key,
      this.borderColor,
      this.focusBorderColor,
      this.fillColor,
      this.borderWidth,
      this.borderRadius,
      required this.item,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      this.textStyle});

  final List<String> item;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? fillColor;
  final int? borderWidth;
  final int? borderRadius;

  final String? hint;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
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
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 25,
        iconEnabledColor: ColorApp.primary,
        openMenuIcon: Icon(
          Icons.arrow_drop_up,
          color: ColorApp.danger,
        ),
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        isOverButton: false,
        maxHeight: 200,
        decoration: BoxDecoration(
          color: ColorApp.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(0.5, 1), blurRadius: 3)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thumbColor: const WidgetStatePropertyAll(ColorApp.info),
          thickness: WidgetStateProperty.all(6),
          thumbVisibility: WidgetStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      items: item
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      color: ColorApp.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'form tidak boleh kosong'.toLowerCase();
        }
        return null;
      },
      onChanged: (value) {
        controller.text = value ?? '';
      },
    );
  }
}
