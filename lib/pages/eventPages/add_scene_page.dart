import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/add_scene_page_controller.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddScenePage extends GetView<AddScenePageController> {
  const AddScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                selectPlan(),
                repentitionTimeTitle,
                selectDay(),
                selectTime,
                saveButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get saveButton => Padding(
        padding: EdgeInsets.only(top: 8.w),
        child: GestureDetector(
          onTap: () => controller.saveSceneButton(),
          child: Container(
            height: 12.w,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(4.w),
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.pink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 2.5,
              ),
            ),
            child: Obx(
              () => SizedBox(
                width: 90.w,
                child: controller.loading.value
                    ? Center(
                        child: SizedBox(
                          height: 9.w,
                          width: 9.w,
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(Get.context!).colorScheme.onTertiary,
                          ),
                        ),
                      )
                    : Center(
                        child: Text('Save Scene', style: pageTitleTextStyle),
                      ),
              ),
            ),
          ),
        ),
      );

  Widget get selectTime => Padding(
        padding: EdgeInsets.only(top: 8.w),
        child: Column(
          children: [
            TimePickerSpinner(
              time: DateTime.now(),
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
              onTimeChange: (time) =>
                  controller.setClock(time.hour, time.minute),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.w),
              child: Obx(
                () => Text(
                  '''Clock: ${controller.hour.value < 10 ? "0${controller.hour.value}" : controller.hour.value}:${controller.minute.value < 10 ? "0${controller.minute.value}" : controller.minute.value}''',
                  style: GoogleFonts.inter(
                    color: Theme.of(Get.context!).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 6.2.w,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget selectPlan() {
    Widget planWidget(int index, String title) {
      return Obx(
        () => GestureDetector(
          onTap: () => controller.planIndex.value = index,
          child: Container(
            margin: index == 0 ? null : EdgeInsets.only(left: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.planIndex.value == index
                    ? Theme.of(Get.context!).colorScheme.primary
                    : Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(Get.context!).colorScheme.onBackground,
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: pageTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: SizedBox(
        height: 37,
        child: Row(
          children: [
            planWidget(0, 'Wake up plan'),
            planWidget(1, 'Sleep plan'),
          ],
        ),
      ),
    );
  }

  Widget selectDay() {
    Widget dayWidget(int index, String title) {
      return GestureDetector(
        onTap: () => controller.dayIndex.value = index,
        child: Obx(
          () => Container(
            margin: index == 0 ? null : EdgeInsets.only(left: 1.5.w),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.dayIndex.value == index
                    ? Theme.of(Get.context!).colorScheme.primary
                    : Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(Get.context!).colorScheme.onBackground,
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: pageTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: SizedBox(
        height: 37,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            dayWidget(0, 'Sun'),
            dayWidget(1, 'Mon'),
            dayWidget(2, 'Tues'),
            dayWidget(3, 'Wed'),
            dayWidget(4, 'Thur'),
            dayWidget(5, 'Fri'),
            dayWidget(6, 'Sat'),
          ],
        ),
      ),
    );
  }

  Widget get title => Padding(
        padding: EdgeInsets.only(top: 3.w),
        child: Text('Add Scenes', style: pageTitleTextStyle),
      );
  Decoration get backgroundDecoration => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/device_detail_page_bg.png'),
          fit: BoxFit.cover,
        ),
      );
  Widget get repentitionTimeTitle => Padding(
        padding: EdgeInsets.only(top: 8.w),
        child: Text(
          'Repentition Time',
          style: pageTitleTextStyle.copyWith(fontSize: 5.w),
        ),
      );
}
