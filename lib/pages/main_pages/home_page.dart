// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/builders/home_page_device_builder.dart';
import 'package:flutter_iot_energy/controller/home_page_controller.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
      appBar: pageAppbar,
      body: SmartRefresher(
        enablePullUp: true,
        header: const ClassicHeader(),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text('pull up load');
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text('Load Failed! Click retry!');
            } else if (mode == LoadStatus.canLoading) {
              body = const Text('release to load more');
            } else {
              body = const Text('No more Data');
            }
            return SizedBox(
              height: 55,
              child: Center(child: body),
            );
          },
        ),
        onRefresh: controller.refreshPage,
        controller: controller.refreshController,
        child: ListView(
          children: [
            profileIcon,
            helloText,
            controlDeviceCount(),
          ],
        ),
      ),
    );
  }

  Widget controlDeviceCount() {
    return Obx(() {
      if (controller.accountTotalDevicesController.value > 0) {
        return mainBody();
      } else {
        return nullBody();
      }
    });
  }

  Widget nullBody() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20.w),
          width: 50.w,
          child: Text(
            "You haven't added a device yet.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Theme.of(Get.context!).colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 5.w,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed<Object>(Routes.pairDevicePage),
          child: Container(
            margin: EdgeInsets.only(top: 3.w),
            height: 12.w,
            width: 48.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(Get.context!).colorScheme.tertiary,
                    Theme.of(Get.context!).colorScheme.primaryContainer,
                  ],
                ),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                'Add Now',
                style: GoogleFonts.inter(
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 4.5.w,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget mainBody() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.w),
          child: SizedBox(
            width: 87.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  topWidget(
                    controller.accountTotalSceneController.value.toString(),
                    'Online Scene',
                    'assets/images/home_scene_icon.png',
                    13.w,
                    8.w,
                    BoxFit.cover,
                    0,
                  ),
                  topWidget(
                    controller.accountTotalDevicesController.value.toString(),
                    'Active Devices',
                    'assets/images/home_device_icon.png',
                    8.w,
                    8.w,
                    BoxFit.fill,
                    1,
                  ),
                  topWidget(
                    '${controller.accountTotalVoltageController.value} W',
                    'Total Energy',
                    'assets/images/home_energy_icon.png',
                    8.w,
                    8.w,
                    BoxFit.fill,
                    2,
                  ),
                  // topWidget(),
                  // topWidget(),
                ],
              ),
            ),
          ),
        ),
        batteriesTitle,
        deviceBuilder,
      ],
    );
  }

  Widget get deviceBuilder => const BuilderHomePageDevice();

  Widget get batteriesTitle => Padding(
        padding: EdgeInsets.only(top: 7.w, left: 3.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Batteries',
            style: GoogleFonts.inter(
              color: Theme.of(Get.context!).colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 7.w,
            ),
          ),
        ),
      );

  Widget topWidget(
    String count,
    String description,
    String path,
    double width,
    double height,
    BoxFit fit,
    int widgetCount,
  ) {
    return Container(
      height: 33.w,
      width: 23.w,
      padding: EdgeInsets.symmetric(vertical: 3.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: GradientBoxBorder(
          width: 1.7,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink.withOpacity(0.7),
              Theme.of(Get.context!).colorScheme.tertiary.withOpacity(0.7),
            ],
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(path),
                fit: fit,
              ),
            ),
          ),
          Container(
            child: (controller.accountTotalVoltageController.value == -1 &&
                    widgetCount == 2)
                ? SizedBox(
                    height: 6.w,
                    width: 6.w,
                    child: const CircularProgressIndicator(),
                  )
                : Text(
                    count,
                    style: GoogleFonts.inter(
                      color: Theme.of(Get.context!).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.w,
                    ),
                  ),
          ),
          SizedBox(
            width: 15.w,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Theme.of(Get.context!).colorScheme.secondary,
                fontSize: 3.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar get pageAppbar => AppBar(
        elevation: 0,
        backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
        title: Text(
          'Energy',
          style: GoogleFonts.inter(
            fontSize: 6.w,
            fontWeight: FontWeight.bold,
            color: Theme.of(Get.context!).colorScheme.secondary,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(1.3.w),
          child: Image.asset('assets/images/logo_icon.png'),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.navigatePairPage(),
            child: Padding(
              padding: EdgeInsets.only(right: 2.4.w, left: 2.4.w, top: 1.5.w),
              child: Icon(
                FontAwesomeIcons.plugCirclePlus,
                color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                size: 7.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.w, left: 2.4.w, top: 1.5.w),
            child: Icon(
              FontAwesomeIcons.solidBell,
              color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
              size: 7.w,
            ),
          )
        ],
      );

  Widget get profileIcon => SizedBox(
        height: 13.h,
        child: Image.asset(
          'assets/images/pp_icon.png',
        ),
      );
  Widget get helloText => Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Hello $accountName!\n',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  fontSize: 5.w,
                ),
              ),
              TextSpan(
                text: 'Welcome to your energy station!',
                style: GoogleFonts.inter(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .secondary
                      .withOpacity(0.3),
                  fontSize: 4.w,
                ),
              ),
            ],
          ),
        ),
      );
}
