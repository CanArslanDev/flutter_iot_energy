import 'package:flutter_iot_energy/controller/sign_in_controller.dart';
import 'package:get/get.dart';

import '../controller/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
