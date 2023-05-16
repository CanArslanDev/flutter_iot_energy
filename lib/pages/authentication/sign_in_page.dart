import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/sign_in_controller.dart';
import '../../routes/routes.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: backgroundDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    title,
                    titleDescription,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                      child: Column(
                        children: [
                          emailField,
                          passwordField,
                          recoveryPassword,
                          signInButton,
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    continueText,
                    googleButton,
                    registerText,
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void recoveryPasswordDialog() {
    showGeneralDialog(
      context: Get.context!,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Obx(() => Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: (controller.recoveryPasswordSended.value == false)
                      ? 55.w
                      : 45.w,
                  width: 90.w,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 4.w),
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context!).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(4.w)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.w,
                        ),
                        child: Text(
                          "Recovery Password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              decoration: TextDecoration.none,
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.7),
                              fontSize: 5.5.w,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 1.w,
                        ),
                        child: SizedBox(
                          width: 80.w,
                          child: Text(
                            (controller.recoveryPasswordSended.value == false)
                                ? "If you have forgotten your password, you can reset your password by typing your e-mail address below."
                                : "Please check your mail.",
                            style: GoogleFonts.inter(
                              decoration: TextDecoration.none,
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.5),
                              fontSize: 3.7.w,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: SizedBox(
                            width: 82.5.w,
                            child: TextField(
                              controller: controller.dialogEmailFieldController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3.5.w, horizontal: 3.w),
                                isCollapsed: true,
                                filled: true,
                                hintText: "Email",
                                hintStyle: GoogleFonts.inter(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onSurface,
                                    fontWeight: FontWeight.bold),
                                fillColor: Theme.of(Get.context!)
                                    .colorScheme
                                    .onBackground,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary
                                        .withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary
                                        .withOpacity(0.3),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary
                                        .withOpacity(0.3),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary
                                        .withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.w, right: 3.2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 9.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: DefaultTextStyle(
                                    style: GoogleFonts.inter(
                                        color: Theme.of(Get.context!)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 5.w),
                                    child: const Text(
                                      "Back",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.5.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.recoveryPasswordSended.value ==
                                    false) {
                                  controller.recoveryPassword(controller
                                      .dialogEmailFieldController.text);
                                }
                              },
                              child: Container(
                                height: 9.w,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: (controller
                                              .recoveryPasswordSended.value ==
                                          false)
                                      ? Theme.of(Get.context!)
                                          .colorScheme
                                          .primary
                                      : Theme.of(Get.context!)
                                          .colorScheme
                                          .inverseSurface,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (controller.recoveryPasswordSended
                                                  .value ==
                                              false)
                                          ? Theme.of(Get.context!)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.4)
                                          : Theme.of(Get.context!)
                                              .colorScheme
                                              .inverseSurface
                                              .withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: (controller
                                            .recoveryPasswordSended.value ==
                                        false)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DefaultTextStyle(
                                            style: GoogleFonts.inter(
                                                color: Theme.of(Get.context!)
                                                    .colorScheme
                                                    .background,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 5.w),
                                            child: const Text(
                                              "Send",
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.paperPlane,
                                            color: Theme.of(Get.context!)
                                                .colorScheme
                                                .background,
                                            size: 5.w,
                                          )
                                        ],
                                      )
                                    : Center(
                                        child: DefaultTextStyle(
                                          style: GoogleFonts.inter(
                                              color: Theme.of(Get.context!)
                                                  .colorScheme
                                                  .background,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 5.w),
                                          child: const Text(
                                            "Sended",
                                          ),
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
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
  }

  Widget get registerText => GestureDetector(
        onTap: () => Get.offAllNamed(
          Routes.signUpPage,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.8.w),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Not a register? ",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(Get.context!).colorScheme.outline,
                        fontSize: 3.7.w)),
                TextSpan(
                    text: "Register now",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                        fontSize: 4.w)),
              ],
            ),
          ),
        ),
      );

  Widget get continueText => Padding(
        padding: EdgeInsets.only(bottom: 1.5.h),
        child: Text(
          "Or continue with",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).colorScheme.outline,
              fontSize: 3.7.w),
        ),
      );

  Widget get googleButton => Padding(
        padding: EdgeInsets.only(bottom: 13.w),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () => controller.signInGoogle(),
            child: Container(
              height: 12.5.w,
              width: 29.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Theme.of(Get.context!).colorScheme.onBackground,
                      width: 3)),
              child: Padding(
                padding: EdgeInsets.all(1.3.w),
                child: Image.asset(
                  "assets/images/google_icon.png",
                ),
              ),
            ),
          ),
        ),
      );

  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/auth_bg_image.png"),
          fit: BoxFit.cover,
        ),
      );

  Widget get title => Padding(
        padding: EdgeInsets.only(top: 3.h),
        child: Text(
          "Hello Again!",
          style: GoogleFonts.inter(
              color: Theme.of(Get.context!).colorScheme.secondary,
              fontWeight: FontWeight.w500,
              fontSize: 8.5.w),
        ),
      );

  Widget get titleDescription => Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: SizedBox(
          width: 70.w,
          child: Text(
            "Welcome back you've been missed!",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: Theme.of(Get.context!).colorScheme.onTertiary,
                fontWeight: FontWeight.w500,
                fontSize: 5.5.w),
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: SizedBox(
          height: 7.h,
          child: TextField(
            controller: controller.emailFieldController,
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
              hintText: "Email",
              hintStyle: GoogleFonts.inter(
                  color: Theme.of(Get.context!).colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
              fillColor: Theme.of(Get.context!).colorScheme.onBackground,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      );

  Widget get passwordField => Padding(
        padding: EdgeInsets.only(top: 1.5.h),
        child: SizedBox(
          height: 7.h,
          child: Obx(() => TextField(
                controller: controller.passwordFieldController,
                maxLines: 1,
                obscureText:
                    (controller.passwordHint.value == false) ? false : true,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => controller.passwordHint.value =
                        !controller.passwordHint.value,
                    child: Icon(
                      (controller.passwordHint.value == false)
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                  ),
                  filled: true,
                  hintText: "Password",
                  hintStyle: GoogleFonts.inter(
                      color: Theme.of(Get.context!).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                  fillColor: Theme.of(Get.context!).colorScheme.onBackground,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )),
        ),
      );

  Widget get recoveryPassword => Padding(
        padding: EdgeInsets.only(top: 1.5.h),
        child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => recoveryPasswordDialog(),
              child: Text(
                "Recovery Password",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(Get.context!).colorScheme.outline,
                    fontSize: 3.7.w),
              ),
            )),
      );
  Widget get signInButton => Padding(
        padding: EdgeInsets.only(top: 3.2.h),
        child: InkWell(
          onTap: () => controller.signIn(),
          child: Container(
            height: 6.3.h,
            width: 85.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(Get.context!).colorScheme.onPrimary,
                  spreadRadius: 1.5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Sign In",
                style: GoogleFonts.inter(
                    color: Theme.of(Get.context!).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 4.5.w),
              ),
            ),
          ),
        ),
      );
}
