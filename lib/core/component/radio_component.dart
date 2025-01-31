import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';

import 'text_component.dart';

class RadioComponent extends StatelessWidget {
  const RadioComponent(
      {super.key,
      this.title,
      this.color,
      required this.value,
      required this.onchange});

  final String? title;
  final Color? color;
  final bool value;
  final ValueChanged<bool> onchange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        title != null ? TextP(text: '$title') : const SizedBox(),
        GFCheckbox(
          inactiveIcon: null,
          size: 23,
          inactiveBorderColor: ColorApp.secondary,
          activeBgColor: color ?? ColorApp.warning,
          onChanged: onchange,
          value: value,
        ),
      ],
    );
  }
}