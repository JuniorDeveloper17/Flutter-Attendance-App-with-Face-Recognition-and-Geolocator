import 'package:get/get.dart';

class Api extends GetxController {
  RxString api = ''.obs;
}

final apiService = Get.put(Api(), permanent: true);
