import 'package:flutter_iot_energy/controller/device_detail_page_controller.dart';
import 'package:get/get.dart';

///Device Binding For Getx
class DeviceDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DeviceDetailPageController.new);
  }
}
