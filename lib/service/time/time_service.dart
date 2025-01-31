import 'dart:async';

import 'package:get/get.dart';

class TimeService extends GetxController {
  final time = DateTime.now().obs;

  StreamSubscription? timeNow;

  @override
  void onInit() {
    streamTime();
    super.onInit();
  }

  void streamTime() {
    Stream<DateTime> timeStream = Stream.periodic(
      const Duration(seconds: 1),
      (int count) => DateTime.now(),
    );
    timeNow = timeStream.listen((newTime) {
      time.value = newTime;
    });
  }
}
