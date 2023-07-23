// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/scene_page_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ui/text_style.dart';

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
            children: [appbar, sceneWidget, sceneWidget],
          ),
        ),
      ),
    );
  }

  Widget get sceneWidget => Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
        margin: EdgeInsets.symmetric(vertical: 1.w),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(Get.context!).colorScheme.onTertiary.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(Get.context!).colorScheme.onBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wake up plan",
                    overflow: TextOverflow.ellipsis,
                    style: pageTitleTextStyle.copyWith(fontSize: 5.5.w),
                  ),
                  Text(
                    "Clock 23:20",
                    style: pageDescriptionTextStyle.copyWith(fontSize: 3.8.w),
                  )
                ],
              ),
            ),
            CupertinoSwitch(value: true, onChanged: (value) {}),
          ],
        ),
      );

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
