import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../routes/routes.dart';
import '../services/value_service.dart';
import 'base_controller.dart';

class HomePageController extends BaseController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Rx<int> accountTotalDevicesController = 0.obs;
  Rx<int> accountTotalSceneController = 0.obs;
  Rx<int> accountTotalVoltageController = (-1).obs;

  @override
  void onInit() async {
    super.onInit();
    accountTotalDevicesController.value = accountTotalDevices;
    accountTotalSceneController.value = accountTotalActiveScene;
    accountTotalVoltageController.value =
        await FirebaseService().getAllDevicesVoltage(accountId);
  }

  void navigatePairPage() {
    Get.toNamed(Routes.pairDevicePage);
  }

  void refreshPage() async {
    accountTotalVoltageController.value = -1;
    int deviceCount = await FirebaseService().getTotalDeviceCount(accountId);
    int sceneCount =
        await FirebaseService().getTotalActiveSceneCount(accountId);
    accountTotalVoltageController.value =
        await FirebaseService().getAllDevicesVoltage(accountId);
    ValueService().changeTotalDevices(deviceCount);
    ValueService().changeTotalScene(sceneCount);
    // print(await FirebaseService().getAllDevicesVoltage(accountId));
    accountTotalDevicesController.value = deviceCount;
    accountTotalSceneController.value = sceneCount;
    refreshController.refreshCompleted();
  }
}
