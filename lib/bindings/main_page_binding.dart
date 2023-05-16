import 'package:get/get.dart';

import '../controller/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
