import 'package:flutter_iot_energy/controller/pair_device_page.dart';
import 'package:get/get.dart';

class PairDevicePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PairDevicePageController());
  }
}
