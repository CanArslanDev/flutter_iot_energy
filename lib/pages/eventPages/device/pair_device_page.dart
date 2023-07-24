import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/device/pair_device_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PairDevicePage extends GetView<PairDevicePageController> {
  const PairDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              topTitle,
              topCard,
              subTitle,
              subTitle1(
                '1.Select Type',
                EdgeInsets.only(left: 5.w, bottom: 3.w, top: 2.w),
              ),
              selectButtonRow,
              subTitle1(
                '2.Select Name Your Device',
                EdgeInsets.only(left: 5.w, top: 5.w),
              ),
              descriptionTitle(
                'Choose a game to find your device more easily.',
              ),
              textFieldName,
              subTitle1(
                '3.Type Device ID',
                EdgeInsets.only(left: 5.w, top: 1.w),
              ),
              descriptionTitle(
                'Choose a game to find your device more easily.',
              ),
              textFieldDevice,
              findButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get findButton => Obx(
        () => GestureDetector(
          onTap: () => controller.findDevice(),
          child: Container(
            margin: EdgeInsets.only(top: 2.5.w),
            height: 13.w,
            width: 90.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: (controller.findingDevice.value == false)
                  ? Text(
                      'Find Device',
                      style: GoogleFonts.inter(
                        color: Theme.of(Get.context!).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.w,
                      ),
                    )
                  : CircularProgressIndicator(
                      color: Theme.of(Get.context!).colorScheme.onBackground,
                    ),
            ),
          ),
        ),
      );

  Widget get textFieldName => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.w),
          child: SizedBox(
            width: 80.w,
            child: TextField(
              controller: controller.nameFieldController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.w),
                isCollapsed: true,
                filled: true,
                hintText: 'Type Name',
                hintStyle: GoogleFonts.inter(
                  color: Theme.of(Get.context!).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Theme.of(Get.context!).colorScheme.onBackground,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  Widget get textFieldDevice => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.w),
          child: SizedBox(
            width: 80.w,
            child: TextField(
              controller: controller.deviceFieldController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.w),
                isCollapsed: true,
                filled: true,
                hintText: 'Type Device ID',
                hintStyle: GoogleFonts.inter(
                  color: Theme.of(Get.context!).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Theme.of(Get.context!).colorScheme.onBackground,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get selectButtonRow => Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              plugButtons(
                'Battery',
                'assets/images/battery_icon_small.png',
                0,
                () => controller.buttonType.value = 0,
              ),
              plugButtons(
                'Plug',
                'assets/images/plug_icon_a_small.png',
                1,
                () => controller.buttonType.value = 1,
              ),
              plugButtons(
                'Other',
                'assets/images/plug_icon_other_small.png',
                2,
                () => controller.buttonType.value = 2,
              ),
            ],
          ),
        ),
      );

  Widget plugButtons(
    String title,
    String path,
    int onActive,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 27.w,
        height: 11.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: (onActive == controller.buttonType.value)
                ? Theme.of(Get.context!).colorScheme.primary
                : Theme.of(Get.context!)
                    .colorScheme
                    .onTertiary
                    .withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(Get.context!).colorScheme.onSurfaceVariant,
              spreadRadius: 2,
              blurRadius: 8,
            ),
            BoxShadow(
              color: Theme.of(Get.context!).colorScheme.onBackground,
              spreadRadius: -1,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 1.w),
          child: Row(
            children: [
              Image.asset(
                path,
                width: 7.5.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.5.w),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Theme.of(Get.context!).colorScheme.onTertiary,
                    fontSize: 3.8.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget subTitle1(String title, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.inter(
            color:
                Theme.of(Get.context!).colorScheme.onTertiary.withOpacity(0.7),
            fontSize: 5.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget descriptionTitle(String desc) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.w,
        top: 2.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 70.w,
          child: Text(
            desc,
            style: GoogleFonts.inter(
              color: Theme.of(Get.context!)
                  .colorScheme
                  .onTertiary
                  .withOpacity(0.5),
              fontSize: 3.5.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget get topTitle => Padding(
        padding: EdgeInsets.only(left: 5.w, top: 3.w, bottom: 3.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pair Device',
            style: GoogleFonts.inter(
              color: Theme.of(Get.context!).colorScheme.secondary,
              fontSize: 7.5.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  Widget get subTitle => Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          top: 3.w,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pair Your Device',
            style: GoogleFonts.inter(
              color: Theme.of(Get.context!).colorScheme.onTertiary,
              fontSize: 6.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget get topCard => Padding(
        padding: EdgeInsets.only(top: 2.w),
        child: Center(
          child: Container(
            height: 40.w,
            width: 90.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .secondary
                      .withOpacity(0.08),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(Get.context!).colorScheme.primary,
                    Theme.of(Get.context!).colorScheme.onTertiary.withOpacity(0)
                  ],
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          'IOT Energy',
                          style: GoogleFonts.inter(
                            color: Theme.of(Get.context!)
                                .colorScheme
                                .onTertiary
                                .withOpacity(0.3),
                            fontSize: 4.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'How it works?',
                        style: GoogleFonts.inter(
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary
                              .withOpacity(0.7),
                          fontSize: 6.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.5.w),
                        child: SizedBox(
                          width: 60.w,
                          child: Text(
                            '''1.You must enter the ID number written on the back of your device in the field below.''',
                            style: GoogleFonts.inter(
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onTertiary
                                  .withOpacity(0.65),
                              fontSize: 2.8.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.w),
                        child: SizedBox(
                          width: 60.w,
                          child: Text(
                            '''2.You can control your device and create scenarios from the home page.''',
                            style: GoogleFonts.inter(
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onTertiary
                                  .withOpacity(0.65),
                              fontSize: 2.8.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/plug_icon.png',
                  width: 20.w,
                ),
              ],
            ),
          ),
        ),
      );
}
