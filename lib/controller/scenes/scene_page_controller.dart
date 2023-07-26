// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/controller/device/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:get/get.dart';

//Base Controller For Getx
class ScenePageController extends BaseController {
  @override
  void onClose() {
    Get.put(DeviceDetailPageController()).turnPage();
    super.onClose();
  }

  void routeToAddScenePage() {
    Get.toNamed<Object>(Routes.addScenePage);
  }
}
