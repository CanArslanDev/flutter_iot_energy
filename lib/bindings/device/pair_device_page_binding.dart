import 'package:flutter_iot_energy/controller/device/pair_device_page.dart';
import 'package:get/get.dart';

///Paire Device Binding For Getx
class PairDevicePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PairDevicePageController.new);
  }
}
