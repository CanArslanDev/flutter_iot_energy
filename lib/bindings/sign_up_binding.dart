import 'package:flutter_iot_energy/controller/sign_up_controller.dart';
import 'package:get/get.dart';

///Sing Up Binding For Getx
class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SignUpController.new);
  }
}
