import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

class DeviceDetailPageController extends BaseController {
//   @override
//   void onInit() {
//     super.onInit();
//   }
  @override
  void onClose() {
    deviceSubscription.cancel();
    super.onClose();
  }

  late DatabaseReference _deviceRef;
  late StreamSubscription<Object> deviceSubscription;
  String deviceId = '';
  Rx<double> voltage = 0.0.obs;
  Rx<int> ampere = 0.obs;
  Rx<int> percentage = 0.obs;
  Rx<String> date = ''.obs;
  Rx<bool> active = true.obs;
  Rx<bool> power = false.obs;
  Rx<int> watt = 0.obs;
  Rx<bool> charging = false.obs;
  bool initialize = false;
  Rx<int> totalSceneCount = 1000.obs;
  int deviceType = 0;
  String deviceDataId = '';
  String deviceName = '';

  Future<void> initializeId(
    String id,
    int type,
    String dataIdNumber,
    String deviceNameVoid,
  ) async {
    initialize = true;
    deviceId = id;
    deviceType = type;
    deviceDataId = dataIdNumber;
    deviceName = deviceNameVoid;
    _deviceRef = FirebaseDatabase.instance.ref().child('devices/$id');
    totalSceneCount.value =
        await FirebaseService().getDeviceTotalSceneCount(id);
    streamListen();
  }

  Future<void> changeChargingStatus() async {
    if (active.value) {
      await FirebaseService()
          .setDeviceCharging(deviceId, !charging.value ? 0 : -1);
    } else {
      showErrorSnackbar(
        'Unable to connect to your device',
        'Please plug in your device.',
      );
    }
  }

  Future<void> changePowerStatus() async {
    if (active.value) {
      await FirebaseService()
          .setDevicePower(deviceId, !power.value == true ? 0 : -1);
    } else {
      showErrorSnackbar(
        'Unable to connect to your device',
        'Please plug in your device.',
      );
    }
  }

  void returnBackPage() {
    Get.back<Object>();
  }

  void routeAddScenePage() {
    streamCancel();
    Get.toNamed<Object>(Routes.scenePage);
  }

  void streamListen() {
    deviceSubscription = _deviceRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value! as Map;
        voltage
          ..value = data['voltage'] as double
          ..value = double.parse(voltage.value.toStringAsFixed(2));
        ampere.value = data['ampere'] as int;
        percentage.value = data['percentage'] as int;
        date.value = data['date'] as String;
        watt.value = data['watt'] as int;
        power.value = data['power'] as bool;
        charging.value = data['charging'] as bool;
        active.value = DeviceService().calculateOnlineDevice(
          DateTime.parse(data['date'] as String),
          DateTime.now(),
        );
        // print("--------------------------------------");
        // print('Power: ${power.value} ${power.runtimeType}');
        // print('Active: ${active.value} ${active.runtimeType}');
        // print('Voltage: ${voltage.value} ${voltage.runtimeType}');
        // print('Ampere: ${ampere.value} ${ampere.runtimeType}');
        // print('Percentage: ${percentage.value} ${percentage.runtimeType}');
        // print('Date: ${date.value} ${date.runtimeType}');
        // print('Watt: ${watt.value} ${watt.runtimeType}');
        // print("--------------------------------------");
      }
    });
  }

  Future<void> turnPage() async {
    streamListen();
    totalSceneCount.value =
        await FirebaseService().getDeviceTotalSceneCount(deviceId);
  }

  void streamCancel() {
    deviceSubscription.cancel();
  }
}
