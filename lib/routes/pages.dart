import 'package:flutter_iot_energy/bindings/auth/sign_in_binding.dart';
import 'package:flutter_iot_energy/bindings/auth/sign_up_binding.dart';
import 'package:flutter_iot_energy/bindings/device/device_detail_page_binding.dart';
import 'package:flutter_iot_energy/bindings/device/pair_device_page_binding.dart';
import 'package:flutter_iot_energy/bindings/main_page_binding.dart';
import 'package:flutter_iot_energy/bindings/scenes/add_scene_page_binding.dart';
import 'package:flutter_iot_energy/bindings/scenes/edit_scene_page_binding.dart';
import 'package:flutter_iot_energy/bindings/scenes/scene_page_binding.dart';
import 'package:flutter_iot_energy/pages/authentication/sign_in_page.dart';
import 'package:flutter_iot_energy/pages/authentication/sign_up_page.dart';
import 'package:flutter_iot_energy/pages/eventPages/device/device_detail_page.dart';
import 'package:flutter_iot_energy/pages/eventPages/device/pair_device_page.dart';
import 'package:flutter_iot_energy/pages/eventPages/scenes/add_scene_page.dart';
import 'package:flutter_iot_energy/pages/eventPages/scenes/edit_scene_page.dart';
import 'package:flutter_iot_energy/pages/eventPages/scenes/scene_page.dart';
import 'package:flutter_iot_energy/pages/main_pages/main_page.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class Pages {
  static List<GetPage<Object>> pages = [
    GetPage(
      name: Routes.signInPage,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.signUpPage,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.mainPage,
      page: () => const MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: Routes.pairDevicePage,
      page: () => const PairDevicePage(),
      binding: PairDevicePageBinding(),
    ),
    GetPage(
      name: Routes.deviceDetailPage,
      page: () => const DeviceDetailPage(),
      binding: DeviceDetailPageBinding(),
    ),
    GetPage(
      name: Routes.addScenePage,
      page: () => const AddScenePage(),
      binding: AddScenePageBinding(),
    ),
    GetPage(
      name: Routes.scenePage,
      page: () => const ScenePage(),
      binding: ScenePageBinding(),
    ),
    GetPage(
      name: Routes.editScenePage,
      page: () => const EditScenePage(),
      binding: EditScenePageBinding(),
    ),
  ];
}
