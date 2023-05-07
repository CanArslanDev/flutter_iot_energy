import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../routes/routes.dart';
import '../services/auth_service.dart';
import '../ui_alerts/get_snackbar.dart';
import 'base_controller.dart';

class SignUpController extends BaseController {
  final emailFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final passwordAgainFieldController = TextEditingController();
  Rx<bool> passwordHint = true.obs;
  Rx<bool> passwordAgainHint = true.obs;
  @override
  void signUp() async {
    print(emailFieldController.text);
    print(usernameFieldController.text);
    print(phoneFieldController.text);
    print(passwordFieldController.text);
    print(passwordAgainFieldController.text);

    if (emailFieldController.text == "" ||
        usernameFieldController.text == "" ||
        phoneFieldController.text == "" ||
        passwordFieldController.text == "" ||
        passwordAgainFieldController.text == "") {
      showInformationSnackbar("Error", "Please fill in all fields");
      return;
    } else if (passwordFieldController.text !=
        passwordAgainFieldController.text) {
      showInformationSnackbar("Error", "Passwords do not match");
      return;
    }
    try {
      await AuthService()
          .signUp(usernameFieldController.text, emailFieldController.text,
              passwordFieldController.text, passwordFieldController.text)
          .then((value) => Get.offAndToNamed(Routes.signInPage));
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar("Error", error.message.toString());
    }
  }
}
