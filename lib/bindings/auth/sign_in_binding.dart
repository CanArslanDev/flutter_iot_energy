import 'package:flutter_iot_energy/controller/auth/sign_in_controller.dart';
import 'package:get/get.dart';

///Sign In Binding For Getx
class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SignInController.new);
  }
}
