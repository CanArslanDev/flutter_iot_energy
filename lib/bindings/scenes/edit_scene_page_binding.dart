import 'package:flutter_iot_energy/controller/scenes/edit_scene_page_controller.dart';
import 'package:get/get.dart';

///Device Binding For Getx
class EditScenePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditScenePageController.new);
  }
}
