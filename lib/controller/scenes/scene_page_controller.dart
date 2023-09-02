// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/controller/device/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:get/get.dart';

//Base Controller For Getx
class ScenePageController extends BaseController {
  Rx<bool> loading = false.obs;
  final controller = Get.put(DeviceDetailPageController());
  RxList<Map<String, dynamic>> sceneList = <Map<String, dynamic>>[].obs;
  @override
  void onClose() {
    Get.put(DeviceDetailPageController()).turnPage();
    super.onClose();
  }

  void routeToAddScenePage() {
    Get.toNamed<Object>(Routes.addScenePage);
  }

  @override
  Future<void> onInit() async {
    await refresh();
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    loading.value = true;
    sceneList.value =
        await FirebaseService().getDeviceSceneAllList(controller.deviceDataId);
    loading.value = false;
  }
}
