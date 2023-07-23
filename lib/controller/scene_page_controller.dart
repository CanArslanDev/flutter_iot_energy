// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:get/get.dart';

//Base Controller For Getx
class ScenePageController extends BaseController {
  void routeToAddScenePage() {
    Get.toNamed<Object>('add-scene-page');
  }
}
