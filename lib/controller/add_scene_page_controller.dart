// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/controller/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

//Base Controller For Getx
class AddScenePageController extends BaseController {
  Rx<int> hour = DateTime.now().hour.obs;
  Rx<int> minute = DateTime.now().minute.obs;
  Rx<int> planIndex = 0.obs;
  Rx<int> dayIndex = 0.obs;
  Rx<bool> loading = false.obs;
  void setClock(int voidHour, int voidMinute) {
    hour.value = voidHour;
    minute.value = voidMinute;
  }

  Future<void> saveSceneButton() async {
    loading.value = true;
    final controller = Get.put(DeviceDetailPageController());
    await FirebaseService().setDeviceScene(
      accountId,
      controller.deviceDataId,
      controller.deviceId,
      controller.deviceType,
      hour.value,
      minute.value,
      dayIndex.value,
      planIndex.value,
    );
    Get.back<Object>();
    showInformationSnackbar(
      'Scene added',
      'The script has been added to your device',
    );
  }
}
