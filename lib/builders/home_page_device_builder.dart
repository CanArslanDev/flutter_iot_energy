import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuilderHomePageDevice extends StatefulWidget {
  const BuilderHomePageDevice({super.key});

  @override
  State<BuilderHomePageDevice> createState() => _BuilderHomePageDeviceState();
}

class _BuilderHomePageDeviceState extends State<BuilderHomePageDevice> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users/$accountId/devices')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Wrap(
            children: snapshot.data!.docs.map((doc) {
              return FutureBuilder(
                future: Future.wait([
                  FirebaseService().getDeviceVoltage(doc['deviceId']),
                  FirebaseService().getDeviceWatt(doc['deviceId']),
                  FirebaseService().getDeviceAmpere(doc['deviceId']),
                  FirebaseService().getDeviceChargePercentage(doc['deviceId']),
                  FirebaseService().getDeviceDate(doc['deviceId']),
                ]),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    int voltage = snapshot.data![0].toInt();
                    int watt = snapshot.data![1].toInt();
                    int ampere = snapshot.data![2].toInt();
                    int percentage = snapshot.data![3].toInt();
                    return leftBox(
                        Alignment.centerLeft,
                        doc['deviceName'],
                        "IOT Device",
                        voltage,
                        watt,
                        ampere,
                        percentage,
                        true,
                        true);
                  } else {
                    return Container();
                  }
                },
              );
            }).toList(),
          );
        }
      },
    );
    // return SizedBox(
    //   width: 100.w,
    //   child: Wrap(
    //     alignment: WrapAlignment.spaceBetween,
    //     runAlignment: WrapAlignment.spaceBetween,
    //     children: [
    //       leftBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       rightBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       leftBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       rightBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //     ],
    //   ),
    // );
  }

  Widget leftBox(Alignment align, String title, String desc, int voltage,
      int watt, int ampere, int percentage, bool charging, bool deviceOn) {
    return Padding(
      padding: (align == Alignment.centerLeft)
          ? EdgeInsets.only(
              top: 1.5.w,
              bottom: 1.w,
              left: 3.w,
            )
          : EdgeInsets.only(
              top: 1.5.w,
              bottom: 1.w,
              right: 3.w,
            ),
      child: Container(
        width: 44.5.w,
        height: 48.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(Get.context!)
                    .colorScheme
                    .secondary
                    .withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 20,
              ),
            ],
            border: GradientBoxBorder(
                width: 2,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(Get.context!)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.7),
                      Theme.of(Get.context!)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.4),
                      Theme.of(Get.context!)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.3),
                      Colors.white.withOpacity(0.0),
                    ]))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Image.asset(
                  "assets/images/home_battery_icon.png",
                  height: 8.w,
                )),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Text(
                "$voltage V",
                style: GoogleFonts.inter(
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 30.0,
                        color: Theme.of(Get.context!)
                            .colorScheme
                            .primary
                            .withOpacity(0.6),
                      ),
                    ],
                    color: Theme.of(Get.context!).colorScheme.primary,
                    fontSize: 6.w,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.w, left: 1.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                      color: Theme.of(Get.context!).colorScheme.secondary,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.3.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  desc,
                  style: GoogleFonts.inter(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onTertiary
                        .withOpacity(0.6),
                    fontSize: 3.4.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.3.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${watt}W ${ampere}A",
                  style: GoogleFonts.inter(
                    color: Theme.of(Get.context!).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.4.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.3.w, right: 2.w, bottom: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 1.2.w,
                        width: 1.2.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (charging == true)
                              ? Theme.of(Get.context!)
                                  .colorScheme
                                  .inverseSurface
                              : Theme.of(Get.context!).colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: (charging == true)
                              ? SizedBox(
                                  width: 20.w,
                                  child: Text(
                                    "Charging ½($percentage)",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .inverseSurface,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.4.w,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 20.w,
                                  child: Text(
                                    "Charge ½$percentage",
                                    style: GoogleFonts.inter(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.4.w,
                                    ),
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 7.w,
                    width: 15.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(Get.context!)
                          .colorScheme
                          .onTertiary
                          .withOpacity(0.1),
                    ),
                    child: AnimatedAlign(
                      alignment: (deviceOn == true)
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: AnimatedContainer(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: (deviceOn == true)
                                ? Colors.blue.shade300
                                : Theme.of(Get.context!).colorScheme.onTertiary,
                            shape: BoxShape.circle),
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        child: Padding(
                          padding: EdgeInsets.all(1.3.w),
                          child: Image.asset(
                            "assets/images/home_shutdown_icon.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
