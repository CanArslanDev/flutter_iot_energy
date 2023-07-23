import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:get/get.dart';

class DeviceDetailPageController extends BaseController {
//   @override
//   void onInit() {
//     super.onInit();
//   }
  @override
  void onClose() {
    _deviceSubscription.cancel();
    super.onClose();
  }

  late DatabaseReference _deviceRef;
  late StreamSubscription<Object> _deviceSubscription;
  String deviceId = '';
  Rx<double> voltage = 0.0.obs;
  Rx<int> ampere = 0.obs;
  Rx<int> percentage = 0.obs;
  Rx<String> date = ''.obs;
  Rx<bool> active = false.obs;
  Rx<bool> power = false.obs;
  Rx<int> watt = 0.obs;
  bool initialize = false;
  int deviceType = 0;
  String deviceDataId = '';

  void initializeId(
    String id,
    int type,
    String dataIdNumber,
  ) {
    initialize = true;
    deviceId = id;
    deviceType = type;
    deviceDataId = dataIdNumber;
    _deviceRef = FirebaseDatabase.instance.ref().child('devices/$id');
    _deviceSubscription = _deviceRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value! as Map;
        voltage.value = data['voltage'] as double;
        ampere.value = data['ampere'] as int;
        percentage.value = data['percentage'] as int;
        date.value = data['date'] as String;
        watt.value = data['watt'] as int;
        power.value = data['power'] as bool;

        final dt = DateTime.parse(data['date'] as String);
        final dt2 = DateTime.now();
        if (dt.year == dt2.year &&
            dt.month == dt2.month &&
            dt.day == dt2.day &&
            dt.hour == dt2.hour &&
            dt2.minute - 2 <= dt.minute) {
          active.value = true;
        } else {
          active.value = false;
        }
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

  Future<void> changePowerStatus() async {
    await FirebaseService().setDevicePower(deviceId, !power.value ? 0 : -1);
  }

  void returnBackPage() {
    Get.back<Object>();
  }

  void routeAddScenePage() {
    Get.toNamed<Object>('scene-page');
  }
}
