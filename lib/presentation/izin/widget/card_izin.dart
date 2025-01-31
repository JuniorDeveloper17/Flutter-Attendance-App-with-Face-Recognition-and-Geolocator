import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../domain/entity/izin_entity.dart';
import '../../../service/routes/route_name.dart';

class CardIzin extends StatelessWidget {
  const CardIzin({
    super.key,
    required this.data,
  });

  final IzinEntity data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.toNamed(RouteName.detailIzin, arguments: data.id),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ColorApp.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorApp.secondary.withOpacity(0.3),
                  blurRadius: 3,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          tileMode: TileMode.decal,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorApp.primary, ColorApp.info],
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextP(
                          text: DateFormat('MMM')
                              .format(DateTime.parse(data.createdAt!)),
                          color: ColorApp.white,
                        ),
                        TextTitle(
                          text: DateFormat('dd')
                              .format(DateTime.parse(data.createdAt!)),
                          color: ColorApp.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextP(text: 'tipe'),
                            spacer(8),
                            const TextP(text: 'status'),
                           
                          ],
                        )),
                        const SizedBox(width: 30),
                        Flexible(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextP(text: '${data.keterangan}'),
                            spacer(5),
                            TextP(
                              text: data.status == true
                                  ? 'di izinkan'
                                  : 'ditinjau',
                              color: data.status == true
                                  ? ColorApp.success
                                  : ColorApp.warning,
                            ),
                        
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
