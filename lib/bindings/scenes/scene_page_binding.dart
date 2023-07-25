import 'package:flutter_iot_energy/controller/scenes/scene_page_controller.dart';
import 'package:get/get.dart';

///Device Binding For Getx
class ScenePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScenePageController());
  }
}
