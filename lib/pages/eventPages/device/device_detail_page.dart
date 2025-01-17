import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/device/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeviceDetailPage extends GetView<DeviceDetailPageController> {
  const DeviceDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    if (controller.initialize == false) {
      controller.initializeId(
        ((Get.arguments as List)[0] as Object) as String,
        ((Get.arguments as List)[1] as Object) as int,
        ((Get.arguments as List)[2] as Object) as String,
        ((Get.arguments as List)[3] as Object) as String,
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: backgroundDecoration,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appbar(
                  DeviceService().capitalize(DeviceService()
                      .getTypeIntToString(controller.deviceType)),
                ),
                topBody,
                plugIcon,
                centerBody,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get centerBody {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42.w,
            height: 23.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1.5,
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onTertiary
                    .withOpacity(0.22),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Power',
                        style: GoogleFonts.inter(
                          height: 1,
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.8),
                          fontWeight: FontWeight.w900,
                          fontSize: 5.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: Container(
                          height: 5.w,
                          width: 8.w,
                          decoration: BoxDecoration(
                            color: Theme.of(Get.context!)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'ON',
                              style: GoogleFonts.inter(
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .background,
                                fontWeight: FontWeight.bold,
                                fontSize: 3.5.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.w),
                    child: GestureDetector(
                      onTap: () => controller.changePowerStatus(),
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: 9.5.w,
                          width: 27.w,
                          decoration: BoxDecoration(
                            color: controller.power.value
                                ? Theme.of(Get.context!)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.3)
                                : Theme.of(Get.context!)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.25),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AnimatedAlign(
                            alignment: controller.power.value
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            duration: const Duration(seconds: 3),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 3),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: controller.power.value
                                        ? Theme.of(Get.context!)
                                            .colorScheme
                                            .tertiary
                                            .withOpacity(0.3)
                                        : Theme.of(Get.context!)
                                            .colorScheme
                                            .onSecondary
                                            .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: controller.power.value
                                    ? Theme.of(Get.context!)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.6)
                                    : Theme.of(Get.context!)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.5),
                              ),
                              width: 13.w,
                              height: 9.w,
                              child: Icon(
                                Icons.power_settings_new_rounded,
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .background,
                                size: 6.5.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 42.w,
            height: 23.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1.5,
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onTertiary
                    .withOpacity(0.22),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Scenes',
                  style: GoogleFonts.inter(
                    height: 1,
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.8),
                    fontWeight: FontWeight.w900,
                    fontSize: 5.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: GestureDetector(
                    onTap: () => controller.routeAddScenePage(),
                    child: Obx(
                      () => AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity:
                            controller.totalSceneCount.value == 1000 ? 0 : 1,
                        child: controller.totalSceneCount.value == 1000
                            ? SizedBox(
                                height: 9.5.w,
                              )
                            : controller.totalSceneCount.value > 0
                                ? SizedBox(
                                    width: 38.w,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (bounds) =>
                                                const LinearGradient(
                                              colors: [
                                                Colors.blue,
                                                Colors.pink,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(
                                                0,
                                                0,
                                                bounds.width,
                                                bounds.height,
                                              ),
                                            ),
                                            child: Text(
                                              '''${controller.totalSceneCount.value} Active Scene''',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 5.w,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'View Detail',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 3.5.w,
                                              color: Theme.of(Get.context!)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 9.5.w,
                                    decoration: BoxDecoration(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onBackground,
                                      borderRadius: BorderRadius.circular(4.w),
                                      border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [Colors.blue, Colors.pink],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 32.w,
                                      child: Center(
                                        child: Text(
                                          'Create Scene',
                                          style: GoogleFonts.inter(
                                            height: 1,
                                            color: Theme.of(Get.context!)
                                                .colorScheme
                                                .onTertiary
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 4.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get plugIcon {
    return Padding(
      padding: EdgeInsets.only(top: 6.5.w),
      child: GestureDetector(
        onTap: () => controller.changeChargingStatus(),
        child: Obx(
          () => Stack(
            children: [
              Image.asset(
                'assets/images/device_plug_active.png',
                width: 60.w,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: (controller.charging.value == false) ? 1 : 0,
                child: Image.asset(
                  'assets/images/device_plug_deactive.png',
                  width: 60.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get topBody {
    Container buttonWidget(
      Widget icon,
      String title,
      String state,
      Color color,
    ) {
      return Container(
        width: 37.w,
        height: 18.w,
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color:
                Theme.of(Get.context!).colorScheme.onTertiary.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 3.w), child: icon),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title\n',
                    style: GoogleFonts.inter(
                      height: 0.7,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w900,
                      fontSize: 3.7.w,
                    ),
                  ),
                  SizedBox(
                    width: 22.w,
                    child: AutoSizeText(
                      state,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        height: 0.7,
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.5.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 14.w),
      child: Column(
        children: [
          Obx(
            () => AnimatedSize(
              duration: const Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Container(
                height: controller.active.value ? 0 : null,
                margin: EdgeInsets.only(bottom: 4.w),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color:
                      Theme.of(Get.context!).colorScheme.error.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Failed to connect to device',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 5.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '''Please make sure the device is working, if the problem still persists restart the device.''',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => buttonWidget(
                    Text(
                      String.fromCharCode(CupertinoIcons.power.codePoint),
                      style: TextStyle(
                        inherit: false,
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                        fontSize: 9.w,
                        fontWeight: FontWeight.w900,
                        fontFamily:
                            CupertinoIcons.exclamationmark_circle.fontFamily,
                        package:
                            CupertinoIcons.exclamationmark_circle.fontPackage,
                      ),
                    ),
                    'Status',
                    controller.power.value ? 'Active' : 'Deactive',
                    controller.power.value
                        ? Theme.of(Get.context!).colorScheme.tertiary
                        : Theme.of(Get.context!)
                            .colorScheme
                            .onTertiary
                            .withOpacity(0.5),
                  )),
              Obx(
                () => buttonWidget(
                  Image.asset(
                    'assets/images/logo_icon.png',
                    width: 7.w,
                  ),
                  'Voltage',
                  '${controller.voltage.value}V',
                  Theme.of(Get.context!).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget appbar(
    String type,
  ) {
    return SizedBox(
      width: 100.w,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.w),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: GestureDetector(
                    onTap: () => controller.returnBackPage(),
                    child: Container(
                      width: 13.5.w,
                      height: 13.5.w,
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context!).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 9.w,
                        color: Theme.of(Get.context!)
                            .colorScheme
                            .onTertiary
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.6.w),
            child: Center(
              child: Column(
                children: [
                  Text(
                    type,
                    style: GoogleFonts.inter(
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 5.3.w,
                    ),
                  ),
                  Text(
                    controller.deviceName,
                    style: GoogleFonts.inter(
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .secondary
                          .withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 6.4.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/device_detail_page_bg.png'),
          fit: BoxFit.cover,
        ),
      );
}
