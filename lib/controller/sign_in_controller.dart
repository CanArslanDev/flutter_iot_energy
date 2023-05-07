import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_iot_energy/services/storage_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import 'base_controller.dart';

class SignInController extends BaseController {
  final emailFieldController = TextEditingController();
  final dialogEmailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  Rx<bool> passwordHint = true.obs;
  Rx<bool> recoveryPasswordSended = false.obs;
  @override
  void onInit() {
    StorageService().getAutomaticSignAuth(() {
      Get.offAndToNamed(Routes.mainPage);
    });
  }

  void signIn() async {
    if (emailFieldController.text == "" || passwordFieldController.text == "") {
      showInformationSnackbar("Error", "Please fill in all fields");
      return;
    }
    try {
      await AuthService()
          .signIn(emailFieldController.text, passwordFieldController.text)
          .then((value) {
        StorageService().setEmailPasswordAuth(
            emailFieldController.text, passwordFieldController.text);
        Get.offAndToNamed(Routes.mainPage);
      });
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }

  void signInGoogle() async {
    try {
      await AuthService().signInGoogle().then((value) {
        StorageService().setGoogleAuth();
        Get.offAndToNamed(Routes.mainPage);
      });
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }

  void recoveryPassword(String email) async {
    try {
      await AuthService().resetPasswordEmail(email);
      recoveryPasswordSended.value = true;
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }
}
