import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/device/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/controller/scenes/scene_page_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuilderScenePageScene extends GetView<ScenePageController> {
  const BuilderScenePageScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? loadingWidget
          : Column(
              children: controller.sceneList.map((Map<String, dynamic> doc) {
                return sceneWidget(
                  doc['sceneId'] as String,
                  doc['plan'] as int,
                  doc['hour'] as int,
                  doc['minute'] as int,
                  doc['enable'] as bool,
                  doc,
                  () {
                    final controller = Get.put(DeviceDetailPageController());
                    Get.toNamed<Object>(
                      Routes.editScenePage,
                      arguments: [
                        controller.deviceDataId,
                        doc['sceneId'] as String,
                        doc,
                      ],
                    );
                  },
                );
              }).toList(),
            ),
    );
  }

  Widget get loadingWidget => Center(
        child: SizedBox(
          height: 10.w,
          width: 10.w,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget sceneWidget(
    String sceneId,
    int plan,
    int hour,
    int minute,
    dynamic enable,
    Map<String, dynamic> doc,
    void Function()? onTap,
  ) {
    final isEnable = ValueNotifier<bool>(enable as bool);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    DeviceService().getPlanIntToString(plan),
                    overflow: TextOverflow.ellipsis,
                    style: pageTitleTextStyle.copyWith(fontSize: 5.5.w),
                  ),
                  Text(
                    'Clock $hour:$minute',
                    style: pageDescriptionTextStyle.copyWith(fontSize: 3.8.w),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isEnable,
              builder: (context, value, child) => CupertinoSwitch(
                value: value,
                onChanged: (value) {
                  final controller = Get.put(DeviceDetailPageController());
                  FirebaseService().setDeviceSceneEnableValue(
                    controller.deviceDataId,
                    sceneId,
                    value,
                  );
                  isEnable.value = !isEnable.value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
