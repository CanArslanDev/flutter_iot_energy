import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/builders/scene_page_scene_builder.dart';
import 'package:flutter_iot_energy/controller/scenes/scene_page_controller.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScenePage extends GetView<ScenePageController> {
  const ScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: backgroundDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: ListView(
            children: [appbar, const BuilderScenePageScene()],
          ),
        ),
      ),
    );
  }

  Widget get appbar => Padding(
        padding: EdgeInsets.only(bottom: 3.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            GestureDetector(
              onTap: () => controller.routeToAddScenePage(),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 2.w,
                  left: 2.4.w,
                  top: 1.5.w,
                ),
                child: Icon(
                  FontAwesomeIcons.circlePlus,
                  color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                  size: 9.w,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get title => Padding(
        padding: EdgeInsets.only(top: 3.w),
        child: Text('Scenes', style: pageTitleTextStyle),
      );
  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/device_detail_page_bg.png'),
          fit: BoxFit.cover,
        ),
      );
}
