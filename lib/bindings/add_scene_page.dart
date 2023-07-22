import 'package:flutter_iot_energy/controller/add_scene_page_controller.dart';
import 'package:get/get.dart';

///Device Binding For Getx
class AddScenePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddScenePageController.new);
  }
}
