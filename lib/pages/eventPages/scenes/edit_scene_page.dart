import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/scenes/edit_scene_page_controller.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditScenePage extends GetView<EditScenePageController> {
  const EditScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.initialize == false) {
      controller.initializeId(
        ((Get.arguments as List)[0] as Object) as String,
        ((Get.arguments as List)[1] as Object) as String,
        ((Get.arguments as List)[2] as Object)
            as QueryDocumentSnapshot<Object?>,
      );
    }
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
                          .withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      planWidget,
                      clockWidget,
                      enableWidget,
                      deleteScene,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget editWidget(
  //   String title,
  //   int index,
  //   int valueIndex,
  //   List<String> valueList,
  //   void Function(dynamic)? callback,
  // ) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (controller.pressedValue.value == index) {
  //         controller.pressedValue.value = 0;
  //       } else {
  //         controller.pressedValue.value = index;
  //       }
  //     },
  //     child: ColoredBox(
  //       color: Colors.white.withOpacity(0),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(vertical: 0.8.w),
  //         child: Obx(() => Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: pageTitleTextStyle.copyWith(
  //                           fontSize: 5.5.w,
  //                           color: Theme.of(Get.context!)
  //                               .colorScheme
  //                               .onTertiary
  //                               .withOpacity(0.8)),
  //                     ),
  //                     Icon(Icons.arrow_forward_ios_rounded,
  //                         size: 7.w,
  //                         color: Theme.of(Get.context!)
  //                             .colorScheme
  //                             .onTertiary
  //                             .withOpacity(0.8))
  //                   ],
  //                 ),
  //                 AnimatedSize(
  //                   curve: Curves.fastLinearToSlowEaseIn,
  //                   duration: const Duration(seconds: 2),
  //                   child: SizedBox(
  //                     height: controller.pressedValue.value == index ? null
  //: 0,
  //                     width: 100.w,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         for (int i = 0; i < valueList.length; i++)
  //                           GestureDetector(
  //                             onTap: () => callback!(i),
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   color: i == valueIndex
  //                                       ? Colors.grey.shade300
  //                                       : null,
  //                                   borderRadius: BorderRadius.circular(10)),
  //                               padding: const EdgeInsets.all(4),
  //                               child: Text(
  //                                 valueList[i],
  //                                 style: GoogleFonts.inter(
  //                                   color: Theme.of(Get.context!)
  //                                       .colorScheme
  //                                       .onTertiary
  //                                       .withOpacity(0.9),
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 divider
  //               ],
  //             )),
  //       ),
  //     ),
  //   );
  // }

  Widget get savingButton => Obx(
        () => TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: controller.loading.value
                ? controller.loadingController.value
                    ? 1
                    : 0
                : 0,
            end: controller.loading.value
                ? controller.loadingController.value
                    ? 0
                    : 1
                : 0,
          ),
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double opacity, Widget? child) {
            return Opacity(
              opacity: opacity,
              child: Text(
                'Saving...',
                style: pageTitleTextStyle.copyWith(
                  fontSize: 4.5.w,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onTertiary
                      .withOpacity(0.8),
                ),
              ),
            );
          },
          onEnd: () => controller.triggerAnimation(),
        ),
      );

  Widget get deleteScene => Align(
        child: GestureDetector(
          onTap: () {
            if (controller.loading.value == false) {
              controller.deleteScene();
            }
          },
          child: ColoredBox(
            color: Colors.white.withOpacity(0),
            child: Text(
              'Delete Scene',
              style: GoogleFonts.inter(
                color: Theme.of(Get.context!).colorScheme.primary,
                fontSize: 4.5.w,
              ),
            ),
          ),
        ),
      );

  Widget get planWidget => GestureDetector(
        onTap: () {
          if (controller.pressedValue.value == 1) {
            controller.pressedValue.value = 0;
          } else {
            controller.pressedValue.value = 1;
          }
        },
        child: ColoredBox(
          color: Colors.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.8.w),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.planIndex.value == 0
                            ? 'Plan: Wake up'
                            : 'Plan: Sleep',
                        style: pageTitleTextStyle.copyWith(
                          fontSize: 5.5.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.8),
                        ),
                      ),
                      AnimatedRotation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 2),
                        turns: controller.pressedValue.value == 1 ? 0.25 : 0,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 7.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                  AnimatedSize(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 2),
                    child: SizedBox(
                      height: controller.pressedValue.value == 1 ? null : 0,
                      width: 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < controller.planList.length; i++)
                            GestureDetector(
                              onTap: () => controller.changePlanIndex(i),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: i == controller.planIndex.value
                                      ? Colors.grey.shade300
                                      : null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  controller.planList[i],
                                  style: GoogleFonts.inter(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary
                                        .withOpacity(0.9),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  divider
                ],
              ),
            ),
          ),
        ),
      );

  Widget get clockWidget => GestureDetector(
        onTap: () {
          if (controller.pressedValue.value == 2) {
            controller.pressedValue.value = 0;
          } else {
            controller.pressedValue.value = 2;
          }
        },
        child: ColoredBox(
          color: Colors.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.8.w),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '''Clock: ${controller.clockHour}:${controller.clockMinute}''',
                        style: pageTitleTextStyle.copyWith(
                          fontSize: 5.5.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.8),
                        ),
                      ),
                      AnimatedRotation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 2),
                        turns: controller.pressedValue.value == 2 ? 0.25 : 0,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 7.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                  AnimatedSize(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 2),
                    child: SizedBox(
                      height: controller.pressedValue.value == 2 ? null : 0,
                      width: 100.w,
                      child: TimePickerSpinner(
                        time: DateTime(
                          0,
                          0,
                          0,
                          controller.clockHour.value,
                          controller.clockMinute.value,
                        ),
                        normalTextStyle: TextStyle(
                          fontSize: 12.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                        ),
                        highlightedTextStyle: TextStyle(
                          fontSize: 12.w,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .secondary
                              .withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                        spacing: 50,
                        itemHeight: 14.w,
                        itemWidth: 17.w,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          if (time.hour != controller.clockHour.value ||
                              time.minute != controller.clockMinute.value) {
                            controller.changeClock(time.hour, time.minute);
                          }
                        },
                      ),
                    ),
                  ),
                  divider
                ],
              ),
            ),
          ),
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
                  'Enable',
                  style: pageTitleTextStyle.copyWith(
                    fontSize: 5.5.w,
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 4.w,
                  child: Transform.scale(
                    scale: 0.8,
                    child: SizedBox(
                      child: Obx(
                        () => CupertinoSwitch(
                          value: controller.enable.value,
                          onChanged: (value) {
                            controller.changeEnable(value);
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ColoredBox(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit Scene', style: pageTitleTextStyle),
            savingButton,
          ],
        ),
      );

  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/device_detail_page_bg.png'),
          fit: BoxFit.cover,
        ),
      );
}
