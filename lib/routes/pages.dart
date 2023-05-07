import 'package:flutter_iot_energy/bindings/main_page_binding.dart';
import 'package:flutter_iot_energy/bindings/sign_in_binding.dart';
import 'package:flutter_iot_energy/bindings/sign_up_binding.dart';
import 'package:flutter_iot_energy/controller/main_page_controller.dart';
import 'package:flutter_iot_energy/pages/authentication/sign_in_page.dart';
import 'package:flutter_iot_energy/pages/authentication/sign_up_page.dart';
import 'package:flutter_iot_energy/pages/main_pages/main_page.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class Pages {
  static List<GetPage> pages = [
    GetPage(
        name: Routes.signInPage,
        page: () => SignInPage(),
        binding: SignInBinding()),
    GetPage(
        name: Routes.signUpPage,
        page: () => SignUpPage(),
        binding: SignUpBinding()),
    GetPage(
        name: Routes.mainPage,
        page: () => MainPage(),
        binding: MainPageBinding()),
  ];
}
