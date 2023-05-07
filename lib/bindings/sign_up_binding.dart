import 'package:flutter_iot_energy/controller/sign_in_controller.dart';
import 'package:flutter_iot_energy/controller/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
