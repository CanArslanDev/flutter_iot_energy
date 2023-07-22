// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:get/get.dart';

//Base Controller For Getx
class AddScenePageController extends BaseController {
  Rx<int> hour = DateTime.now().hour.obs;
  Rx<int> minute = DateTime.now().minute.obs;
  Rx<int> planIndex = 0.obs;
  Rx<int> dayIndex = 0.obs;
  void setClock(int voidHour, int voidMinute) {
    hour.value = voidHour;
    minute.value = voidMinute;
  }
}
