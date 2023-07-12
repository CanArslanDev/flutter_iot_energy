// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/base_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/auth_service.dart';
import 'package:flutter_iot_energy/services/storage_service.dart';
import 'package:flutter_iot_energy/ui_alerts/get_snackbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInController extends BaseController {
  final emailFieldController = TextEditingController();
  final dialogEmailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  Rx<bool> passwordHint = true.obs;
  Rx<bool> recoveryPasswordSended = false.obs;
  @override
  void onInit() {
    super.onInit();
    StorageService().getAutomaticSignAuth(
      () {
        Get.offAndToNamed<Object>(Routes.mainPage);
      },
      Get.back<Object>,
      autoLoginDialog,
    );
  }

  Future<void> signIn() async {
    if (emailFieldController.text == '' || passwordFieldController.text == '') {
      showInformationSnackbar('Error', 'Please fill in all fields');
      return;
    }
    try {
      await AuthService()
          .signIn(emailFieldController.text, passwordFieldController.text)
          .then((value) {
        StorageService().setEmailPasswordAuth(
          emailFieldController.text,
          passwordFieldController.text,
        );
        Get.offAndToNamed<Object>(Routes.mainPage);
      });
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar('Error', error.message.toString());
    }
  }

  Future<void> signInGoogle() async {
    try {
      await AuthService().signInGoogle().then((value) {
        StorageService().setGoogleAuth();
        Get.offAndToNamed<Object>(Routes.mainPage);
      });
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar('Error', error.message.toString());
    }
  }

  Future<void> recoveryPassword(String email) async {
    try {
      await AuthService().resetPasswordEmail(email);
      recoveryPasswordSended.value = true;
    } on FirebaseAuthException catch (error) {
      showInformationSnackbar('Error', error.message.toString());
    }
  }

  void autoLoginDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGeneralDialog(
        context: Get.context!,
        barrierLabel: 'Barrier',
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.2),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, __, ___) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Align(
                child: Container(
                  height: 33.w,
                  width: 70.w,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 4.w),
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.w),
                        child: Material(
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade900,
                              ],
                            ).createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Auto Login Active',
                              style: GoogleFonts.inter(
                                fontSize: 6.8.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        child: Text(
                          'Please Wait',
                          style: GoogleFonts.inter(
                            fontSize: 5.5.w,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(Get.context!)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.w),
                        child: const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        },
      );
    });
  }
}
