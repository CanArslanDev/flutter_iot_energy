import 'dart:async';

import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/controller/scenes/scene_page_controller.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

class EditScenePageController extends BaseController {
  Rx<int> pressedValue = 0.obs;
  List<String> planList = ['Wake up plan', 'Sleep plan'];
  Rx<int> planIndex = 0.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> loadingController = false.obs;
  Rx<int> clockHour = 0.obs;
  Rx<int> clockMinute = 0.obs;
  Rx<bool> enable = false.obs;
  bool initialize = false;
  String deviceId = '';
  String sceneId = '';

  final firebase = FirebaseService();

  @override
  void onClose() {
    Get.put(ScenePageController()).refresh();
    super.onClose();
  }

  void initializeId(
    String voidDeviceId,
    String voidSceneId,
    Map<String, dynamic> data,
  ) {
    deviceId = voidDeviceId;
    sceneId = voidSceneId;
    planIndex.value = data['plan'] as int;
    clockHour.value = data['hour'] as int;
    clockMinute.value = data['minute'] as int;
    enable.value = data['enable'] as bool;
    initialize = true;
  }

  void triggerAnimation() {
    if (loading.value == true) {
      loadingController.value = !loadingController.value;
    }
  }

  Future<void> changePlanIndex(int value) async {
    planIndex.value = value;
    loading.value = true;
    await firebase.setDeviceScenePlanValue(deviceId, sceneId, value);
    loading.value = false;
  }

  Future<void> changeClock(int hour, int minute) async {
    clockHour.value = hour;
    clockMinute.value = minute;
    loading.value = true;
    await firebase.setDeviceSceneClockValue(deviceId, sceneId, hour, minute);
    loading.value = false;
  }

  Future<void> changeEnable(dynamic value) async {
    enable.value = value! as bool;
    loading.value = true;
    await firebase.setDeviceSceneEnableValue(deviceId, sceneId, value);
    loading.value = false;
  }

  Future<void> deleteScene() async {
    loading.value = true;
    await firebase.deleteDeviceScene(deviceId, sceneId);
    Get.back<Object>(closeOverlays: true);
    showErrorSnackbar(
      'Scene Removed',
      'The scene has been removed to your device',
    );
  }
}
