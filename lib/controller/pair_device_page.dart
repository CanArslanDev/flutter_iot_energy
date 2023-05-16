import 'package:flutter/cupertino.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:get/get.dart';

import '../ui_alerts/get_snackbar.dart';
import 'base_controller.dart';

class PairDevicePageController extends BaseController {
  final nameFieldController = TextEditingController();
  final deviceFieldController = TextEditingController();
  Rx<int> buttonType = 1.obs;
  Rx<bool> findingDevice = false.obs;
  void changeButtonValue(int index) {
    buttonType.value = index;
  }

  void findDevice() async {
    if (nameFieldController.text == "" || deviceFieldController.text == "") {
      return showInformationSnackbar("Error", "Please fill in all fields");
    }
    findingDevice.value = true;
    if (await FirebaseService().getDeviceFound(deviceFieldController.text,
            DeviceService().getTypeIntToString(buttonType.value)) ==
        true) {
      FirebaseService().addDevice(nameFieldController.text.trim(),
          deviceFieldController.text.trim(), buttonType.value);
      ValueService().changeTotalDevices(
          await FirebaseService().getTotalDeviceCount(accountId));
      Get.back();
    } else {
      findingDevice.value = false;
      showInformationSnackbar(
          "Error", "No device found matching this ID or Type.");
    }
  }
}
