import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/dropdown_component.dart';
import '../../../core/component/form_component.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/utils/icons.dart';
import '../controller/izin_controller.dart';
import '../widget/picked_file_widget.dart';

class IzinAddPage extends StatelessWidget {
  const IzinAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final izin = Get.find<IzinController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const TextTitle(text: 'Buat Izin'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
              spacer(30),
              const Row(
                children: [
                  Icon(Icons.short_text, size: 15),
                  SizedBox(width: 10),
                  TextP(text: 'Tipe'),
                ],
              ),
              spacer(5),
              DropdownComponent(
                item: izin.type,
                controller: izin.typeController,
              ),
              spacer(20),
              const Row(
                children: [
                  Icon(MyIcon.edit, size: 15),
                  SizedBox(width: 10),
                  TextP(text: 'Keterangan lebih lanjut'),
                ],
              ),
              spacer(5),
              FormComponent(
                controller: izin.keterangan,
                maxLines: 8,
              ),
              spacer(20),
              const Row(
                children: [
                  Icon(MyIcon.fileAdd, size: 15),
                  SizedBox(width: 10),
                  TextP(text: 'Tambahkan dokumen'),
                ],
              ),
              spacer(5),
              PickedFileWidget(
                image: izin.file,
                ontap: () => izin.file.value == ''
                    ? izin.getImage()
                    : izin.file.value = '',
              ),
              spacer(20),
              ButtonComponent(
                ontap: () => izin.addIzin(),
                text: 'AJUKAN IZIN',
              )
            ],
          ),
          LoadingComponent(isLoading: izin.isLoading)
        ],
      ),
    );
  }
}
