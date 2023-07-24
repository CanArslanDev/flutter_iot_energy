import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/scenes/edit_scene_page_controller.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditScenePage extends GetView<EditScenePageController> {
  const EditScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          decoration: backgroundDecoration,
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(Get.context!).colorScheme.onBackground,
                    border: Border.all(
                        color: Theme.of(Get.context!)
                            .colorScheme
                            .onTertiary
                            .withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      wakeUpWidget,
                      clockWidget,
                      enableWidget,
                      deleteScene,
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  Widget get deleteScene => Align(
        alignment: Alignment.center,
        child: Text(
          "Delete Scene",
          style: GoogleFonts.inter(
            color: Theme.of(Get.context!).colorScheme.primary,
            fontSize: 4.5.w,
          ),
        ),
      );

  Widget get wakeUpWidget => Padding(
        padding: EdgeInsets.symmetric(vertical: 0.8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Plan: Wake up",
                  style: pageTitleTextStyle.copyWith(
                      fontSize: 5.5.w,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.8)),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 7.w,
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.8))
              ],
            ),
            Container(
              color: Colors.white,
              child: AnimatedSize(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 2),
                child: Container(
                  height: 0,
                ),
              ),
            ),
            divider
          ],
        ),
      );

  Widget get clockWidget => Padding(
        padding: EdgeInsets.symmetric(vertical: 0.8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Clock: 23:30",
                  style: pageTitleTextStyle.copyWith(
                      fontSize: 5.5.w,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.8)),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 7.w,
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.8))
              ],
            ),
            Container(
              color: Colors.white,
              child: AnimatedSize(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 2),
                child: Container(
                  height: 0,
                ),
              ),
            ),
            divider
          ],
        ),
      );

  Widget get enableWidget => Padding(
        padding: EdgeInsets.symmetric(vertical: 0.8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable",
                  style: pageTitleTextStyle.copyWith(
                      fontSize: 5.5.w,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.8)),
                ),
                SizedBox(
                  height: 4.w,
                  child: Transform.scale(
                    scale: 0.8,
                    child: SizedBox(
                      child: CupertinoSwitch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              child: AnimatedSize(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 2),
                child: Container(
                  height: 0,
                ),
              ),
            ),
            divider
          ],
        ),
      );

  Widget get divider => const Divider(
        color: Color.fromARGB(255, 201, 201, 201),
      );

  Widget get title => Padding(
        padding: EdgeInsets.only(top: 3.w, bottom: 3.w),
        child: Text('Edit Scene', style: pageTitleTextStyle),
      );

  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/device_detail_page_bg.png'),
          fit: BoxFit.cover,
        ),
      );
}
