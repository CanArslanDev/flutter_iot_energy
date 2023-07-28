import 'package:flutter/cupertino.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

class PairDevicePageController extends BaseController {
  final nameFieldController = TextEditingController();
  final deviceFieldController = TextEditingController();
  Rx<int> buttonType = 0.obs;
  Rx<bool> findingDevice = false.obs;
  Future<void> findDevice() async {
    if (nameFieldController.text == '' || deviceFieldController.text == '') {
      return showErrorSnackbar('Error', 'Please fill in all fields');
    }

    findingDevice.value = true;
    if (await FirebaseService()
            .getAccountDeviceIsExists(deviceFieldController.text) ==
        true) {
      findingDevice.value = false;
      return showErrorSnackbar(
          'Error', '''This device is already in your account''');
    }
    Get.closeAllSnackbars();
    if (await FirebaseService().getDeviceFound(
          deviceFieldController.text,
          DeviceService().getTypeIntToString(buttonType.value),
        ) ==
        true) {
      await FirebaseService().addDevice(
        nameFieldController.text.trim(),
        deviceFieldController.text.trim(),
        buttonType.value,
      );
      ValueService().changeTotalDevices(
        await FirebaseService().getTotalDeviceCount(accountId),
      );
      Get.back<Object>(closeOverlays: true);
    } else {
      findingDevice.value = false;
      showErrorSnackbar(
        'Error',
        'No device found matching this ID or Type.',
      );
    }
  }
}
