import 'package:flutter/material.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../domain/entity/attendance_entity.dart';

class CardPresensi extends StatelessWidget {
  const CardPresensi({
    super.key,
    required this.data,
  });

  final AttendanceEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ColorApp.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorApp.secondary.withOpacity(0.5),
              blurRadius: 3,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                MyIcon.jadwal,
                size: 18,
                color: ColorApp.info,
              ),
              const SizedBox(width: 10),
              TextP(
                  text: TimeFormatter()
                      .formatDate(DateTime.parse(data.createdAt!))),
              Expanded(child: spacer(0)),
              Icon(
                data.status == 'tepat waktu' ? MyIcon.doneAll : MyIcon.done,
                color: data.status == 'tepat waktu'
                    ? ColorApp.success
                    : ColorApp.danger,
              )
            ],
          ),
          const Divider(),
          spacer(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextC(text: 'Waktu Masuk'),
                  TextH1(
                      text: TimeFormatter()
                          .formatTime(DateTime.parse(data.createdAt!)))
                ],
              ),
              const SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: ColorApp.warning,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextC(text: 'Waktu Keluar'),
                  TextH1(
                      text: data.updatedAt == data.createdAt
                          ? ''
                          : TimeFormatter()
                              .formatTime(DateTime.parse(data.updatedAt!)))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
