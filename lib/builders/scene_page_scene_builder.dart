import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/device/device_detail_page_controller.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuilderScenePageScene extends StatelessWidget {
  const BuilderScenePageScene({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeviceDetailPageController());
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(
            'users/$accountId/devices/${controller.deviceDataId}/scenes',
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: snapshot.data!.docs.map((doc) {
              return sceneWidget(
                doc.id,
                doc['plan'] as int,
                doc['hour'] as int,
                doc['minute'] as int,
                doc['enable'] as bool,
                doc,
                () {
                  final controller = Get.put(DeviceDetailPageController());
                  Get.toNamed<Object>(
                    'edit-scene-page',
                    arguments: [
                      controller.deviceDataId,
                      doc.id,
                      doc,
                    ],
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget sceneWidget(
    String sceneId,
    int plan,
    int hour,
    int minute,
    dynamic enable,
    QueryDocumentSnapshot<Object?> doc,
    void Function()? onTap,
  ) {
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
                  )
                ],
              ),
            ),
            CupertinoSwitch(
              value: enable as bool,
              onChanged: (value) {
                final controller = Get.put(DeviceDetailPageController());
                FirebaseService().setDeviceSceneEnableValue(
                  controller.deviceDataId,
                  sceneId,
                  value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
