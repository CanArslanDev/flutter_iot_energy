import 'package:flutter_iot_energy/controller/main_page_controller.dart';
import 'package:get/get.dart';

///Main Page Binding for Getx
class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MainPageController.new);
  }
}
