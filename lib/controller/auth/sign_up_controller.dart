import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  final emailFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final passwordAgainFieldController = TextEditingController();
  Rx<bool> passwordHint = true.obs;
  Rx<bool> passwordAgainHint = true.obs;
  Future<void> signUp() async {
    if (emailFieldController.text == '' ||
        usernameFieldController.text == '' ||
        phoneFieldController.text == '' ||
        passwordFieldController.text == '' ||
        passwordAgainFieldController.text == '') {
      showErrorSnackbar('Error', 'Please fill in all fields');
      return;
    } else if (passwordFieldController.text !=
        passwordAgainFieldController.text) {
      showErrorSnackbar('Error', 'Passwords do not match');
      return;
    }
    try {
      await await AuthService()
          .signUp(
            usernameFieldController.text,
            emailFieldController.text,
            phoneFieldController.text,
            passwordFieldController.text,
          )
          .then((value) => Get.offAllNamed<Object>(Routes.signInPage));
    } on FirebaseAuthException catch (error) {
      showErrorSnackbar('Error', error.message.toString());
    }
  }
}
