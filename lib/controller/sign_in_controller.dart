import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import 'base_controller.dart';

class SignInController extends BaseController {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  Rx<bool> passwordHint = true.obs;
  @override
  // void onInit() {
  //   print("running");
  // }

  void signIn() async {
    if (emailFieldController.text == "" || passwordFieldController.text == "") {
      showInformationSnackbar("Error", "Please fill in all fields");
      return;
    }
    try {
      await AuthService()
          .signIn(emailFieldController.text, passwordFieldController.text)
          .then((value) => Get.offAndToNamed(Routes.mainPage));
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }

  void signInGoogle() {
    try {
      AuthService()
          .signInGoogle()
          .then((value) => Get.offAndToNamed(Routes.mainPage));
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }
}
