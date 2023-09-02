import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/controller/search_page_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/device_service.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/ui/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPageController());
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
      body: SafeArea(
        child: ListView(
          children: [
            title,
            searchBar,
            Obx(
              () => Column(
                children: [
                  ...controller.matchingDevices.map(
                    (deviceName) => FutureBuilder(
                      future: FirebaseService().getDeviceAllData(deviceName.id),
                      builder: (
                        context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot,
                      ) {
                        return AnimatedOpacity(
                          opacity: snapshot.hasData ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: snapshot.hasData
                              ? deviceWidget(
                                  deviceName['deviceId'] as String,
                                  deviceName.id,
                                  deviceName['deviceType'] as int,
                                  deviceName['deviceName'] as String,
                                  snapshot.data!['watt'] as int,
                                  snapshot.data!['ampere'] as int,
                                  snapshot.data!['percentage'] as int,
                                  snapshot.data!['voltage'] as double,
                                  snapshot.data!['power'] as bool,
                                  DeviceService().getIfRechargable(
                                    snapshot.data!['type'] as String,
                                    snapshot.data!['charging'] as bool,
                                  ),
                                )
                              : const SizedBox(),
                        );
                      },
                    ),
                  ),
                  ...controller.matchingScenes.map(
                    (sceneName) => FutureBuilder(
                      future: FirebaseService().getDeviceAllData(
                        sceneName['fromDeviceId'] as String,
                      ),
                      builder: (
                        context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot,
                      ) {
                        return AnimatedOpacity(
                          opacity: snapshot.hasData ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: snapshot.hasData
                              ? sceneWidget(
                                  sceneName['fromDeviceId'] as String,
                                  sceneName.id,
                                  sceneName['fromDeviceId'] as String,
                                  DeviceService().getTypeStringToInt(
                                    snapshot.data!['type'] as String,
                                  ),
                                  sceneName['fromDevice'] as String,
                                  sceneName['sceneName'] as String,
                                  sceneName['enable'] as bool,
                                )
                              : const SizedBox(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Obx(() => BuilderSearchPageWidget(
            //     searchValue: controller.searchText.value)),
            // deviceWidget('Device 1', 25, 2, 50, 5, true, null),
            // deviceWidget('Device 2', 25, 2, 50, 5, true, true),
            // deviceWidget('Device 2', 25, 2, 50, 5, true, false),
            // sceneWidget('Device 2', 'Scene 1', true),
          ],
        ),
      ),
    );
  }

  Widget deviceWidget(
    String deviceId,
    String dataId,
    int deviceType,
    String deviceName,
    int watt,
    int amper,
    int charge,
    dynamic voltage,
    dynamic enable,
    dynamic charging,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed<Object>(
        Routes.deviceDetailPage,
        arguments: [deviceId, deviceType, dataId, deviceName],
      ),
      child: Container(
        height: 20.w,
        margin: EdgeInsets.symmetric(vertical: 1.5.w, horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Theme.of(Get.context!).colorScheme.tertiary,
                Colors.white.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            width: 1.3,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device',
                    style: GoogleFonts.inter(
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.7),
                    ),
                  ),
                  Text(
                    deviceName,
                    style: GoogleFonts.inter(
                      fontSize: 6.2.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                    ),
                  ),
                  Text(
                    '${watt}W ${amper}A',
                    style: GoogleFonts.inter(
                      fontSize: 3.5.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: charging == null
                        ? Text(
                            '''${double.parse(voltage.toString()).toStringAsFixed(2)}V''',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 5.w,
                              color:
                                  Theme.of(Get.context!).colorScheme.tertiary,
                            ),
                          )
                        : Image.asset(
                            charging == true
                                ? 'assets/images/home_battery_icon_online.png'
                                : 'assets/images/home_battery_icon_offline.png',
                            height: 8.5.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.w),
                    child: Text(
                      charging == null
                          ? enable == true
                              ? 'Enable'
                              : 'Disable'
                          : charging == true
                              ? 'Charging %$charge'
                              : 'Charge %$charge',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.4.w,
                        color: charging == null
                            ? enable == true
                                ? Theme.of(Get.context!).colorScheme.tertiary
                                : Theme.of(Get.context!).colorScheme.onTertiary
                            : charging == true
                                ? Theme.of(Get.context!).colorScheme.primary
                                : Theme.of(Get.context!).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sceneWidget(
    String deviceId,
    String sceneId,
    String dataId,
    int deviceType,
    String deviceName,
    String sceneName,
    dynamic enable,
  ) {
    final enableValue = ValueNotifier<bool>(enable as bool);
    return GestureDetector(
      onTap: () => Get.toNamed<Object>(
        Routes.deviceDetailPage,
        arguments: [deviceId, deviceType, dataId, deviceName],
      ),
      child: Container(
        height: 20.w,
        margin: EdgeInsets.symmetric(vertical: 1.5.w, horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Theme.of(Get.context!).colorScheme.inverseSurface,
                Colors.white.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            width: 1.3,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device',
                    style: GoogleFonts.inter(
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.7),
                    ),
                  ),
                  Text(
                    deviceName,
                    style: GoogleFonts.inter(
                      fontSize: 6.2.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                    ),
                  ),
                  Text(
                    'From $deviceName',
                    style: GoogleFonts.inter(
                      fontSize: 3.5.w,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 1.w),
                    child: Text(
                      enable == true ? 'Enable' : 'Disable',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.4.w,
                        color: enable == true
                            ? Theme.of(Get.context!).colorScheme.inverseSurface
                            : Theme.of(Get.context!).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: enableValue,
                    builder: (context, bool value, child) => CupertinoSwitch(
                      value: value,
                      onChanged: (value) {
                        enableValue.value = !enableValue.value;
                        FirebaseService().setDeviceSceneEnableValue(
                          deviceId,
                          sceneId,
                          value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get searchBar => Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.w),
        child: TextField(
          onChanged: (value) => controller.searchData(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: 'Search Device or Scene',
            labelStyle: GoogleFonts.inter(
              fontSize: 4.5.w,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!)
                  .colorScheme
                  .onTertiary
                  .withOpacity(0.6),
            ),
          ),
        ),
      );

  Widget get title => Padding(
        padding: EdgeInsets.only(top: 3.w, left: 4.w, bottom: 1.w),
        child: Text(
          'Search',
          style: pageTitleTextStyle.copyWith(
            color: Theme.of(Get.context!).colorScheme.secondary,
            fontSize: 7.5.w,
          ),
        ),
      );
}
