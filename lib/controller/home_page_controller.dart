import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends BaseController {
  RefreshController refreshController = RefreshController();
  Rx<int> accountTotalDevicesController = 0.obs;
  Rx<int> accountTotalSceneController = 0.obs;
  Rx<int> accountTotalVoltageController = (-1).obs;
  Rx<bool> builderWidgetAlignment = false.obs;
  RxList<String> accountModuleList = RxList();
  Rx<String> moduleFilter = ''.obs;
  Rx<String> builderPath = 'users/$accountId/devices'.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    accountTotalDevicesController.value = accountTotalDevices;
    accountTotalSceneController.value = await FirebaseService().getTotalScene();
    accountTotalVoltageController.value =
        await FirebaseService().getAllDevicesVoltage(accountId);
    accountModuleList.value = await FirebaseService().getAccountModuleList();
  }

  void navigatePairPage() {
    Get.toNamed<Object>(
      Routes.pairDevicePage,
    );
  }

  void setModuleFilter(String value) {
    builderPath
      ..value = ''
      ..value = 'users/$accountId/devices';
    moduleFilter.value = value;
  }

  Future<void> refreshPage() async {
    final deviceCount = await FirebaseService().getTotalDeviceCount(accountId);

    accountModuleList.value = await FirebaseService().getAccountModuleList();
    final sceneCount = await FirebaseService().getTotalScene();
    accountTotalVoltageController.value =
        await FirebaseService().getAllDevicesVoltage(accountId);
    ValueService().changeTotalDevices(deviceCount);
    ValueService().changeTotalScene(sceneCount);
    accountTotalDevicesController.value = deviceCount;
    accountTotalSceneController.value = sceneCount;
    refreshController.refreshCompleted();
  }
}
