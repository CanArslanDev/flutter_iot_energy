import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/sign_up_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

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
                          usernameField,
                          emailField,
                          phoneField,
                          passwordField,
                          passwordAgainField,
                          signInButton,
                          acceptPolicy,
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    registerText,
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget get acceptPolicy => Padding(
        padding: EdgeInsets.only(top: 1.5.h),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: "By registering, you agree to the ",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.outline,
                      fontSize: 3.7.w)),
              TextSpan(
                  text: "Privacy Policy ",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.tertiary,
                      fontSize: 4.w)),
              TextSpan(
                  text: "and ",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.outline,
                      fontSize: 3.7.w)),
              TextSpan(
                  text: "Terms Of Service",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.tertiary,
                      fontSize: 4.w)),
            ],
          ),
        ),
      );

  Widget get registerText => GestureDetector(
        onTap: () => Get.offAndToNamed(Routes.signInPage),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.8.w),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Already a member? ",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(Get.context!).colorScheme.outline,
                        fontSize: 3.7.w)),
                TextSpan(
                    text: "Sign in",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                        fontSize: 4.w)),
              ],
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
        padding: EdgeInsets.only(top: 3.h, left: 4.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Register",
            style: GoogleFonts.inter(
                color: Theme.of(Get.context!).colorScheme.secondary,
                fontWeight: FontWeight.w500,
                fontSize: 8.5.w),
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: EdgeInsets.only(top: 1.h),
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

  Widget get titleDescription => Padding(
        padding: EdgeInsets.only(top: 1.h, left: 4.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 70.w,
            child: Text(
              "You can login to the application by registering",
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                  color: Theme.of(Get.context!).colorScheme.onTertiary,
                  fontWeight: FontWeight.w500,
                  fontSize: 4.w),
            ),
          ),
        ),
      );

  Widget get usernameField => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: SizedBox(
          height: 7.h,
          child: TextField(
            controller: controller.usernameFieldController,
            decoration: InputDecoration(
              filled: true,
              hintText: "Name and Surname",
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
  Widget get phoneField => Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: SizedBox(
          height: 7.h,
          child: IntlPhoneField(
            controller: controller.phoneFieldController,
            disableLengthCheck: true,
            decoration: InputDecoration(
              filled: true,
              hintText: "Phone",
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
        padding: EdgeInsets.only(top: 1.h),
        child: SizedBox(
          height: 7.h,
          child: Obx(
            () => TextField(
              maxLines: 1,
              controller: controller.passwordFieldController,
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
            ),
          ),
        ),
      );
  Widget get passwordAgainField => Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: SizedBox(
          height: 7.h,
          child: Obx(
            () => TextField(
              maxLines: 1,
              controller: controller.passwordAgainFieldController,
              obscureText:
                  (controller.passwordAgainHint.value == false) ? false : true,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => controller.passwordAgainHint.value =
                      !controller.passwordAgainHint.value,
                  child: Icon(
                    (controller.passwordAgainHint.value == false)
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Theme.of(Get.context!).colorScheme.onSurface,
                  ),
                ),
                filled: true,
                hintText: "Password Again",
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
        ),
      );

  Widget get signInButton => Padding(
        padding: EdgeInsets.only(top: 3.2.h),
        child: InkWell(
          onTap: () => controller.signUp(),
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
                "Sign Up",
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
