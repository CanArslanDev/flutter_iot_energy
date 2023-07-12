// ignore_for_file: unnecessary_overrides, public_member_api_docs

import 'package:get/get.dart';

//Base Controller For Getx
class BaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // ignore: avoid_print
    // print("Starting base controller");
  }

  @override
  void onClose() {
    super.onClose();
    // ignore: avoid_print
    // print("Starting base controller");
  }
}
