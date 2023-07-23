import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_energy/routes/routes.dart';
import 'package:flutter_iot_energy/services/firebase_service.dart';
import 'package:flutter_iot_energy/services/value_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///Home Page Device Builder
class BuilderHomePageDevice extends StatefulWidget {
  ///HomePage Super Key
  const BuilderHomePageDevice({super.key});

  @override
  State<BuilderHomePageDevice> createState() => _BuilderHomePageDeviceState();
}

class _BuilderHomePageDeviceState extends State<BuilderHomePageDevice> {
  bool widgetAlignment = false;
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
          return Align(
            alignment: snapshot.data!.docs.length == 1
                ? Alignment.centerLeft
                : Alignment.center,
            child: Wrap(
              children: snapshot.data!.docs.map((doc) {
                final alignment = widgetAlignment;
                widgetAlignment = !widgetAlignment;
                return FutureBuilder(
                  // future: Future.wait([
                  //   FirebaseService().getDeviceVoltage(doc['deviceId']),
                  //   FirebaseService().getDeviceWatt(doc['deviceId']),
                  //   FirebaseService().getDeviceAmpere(doc['deviceId']),
                  //   FirebaseService()
                  //       .getDeviceChargePercentage(doc['deviceId']),
                  //   FirebaseService().getDeviceActive(doc['deviceId']),
                  // ]),
                  future: FirebaseService()
                      .getDeviceAllData(doc['deviceId'] as String),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      final voltage = snapshot.data!['voltage'] as double;
                      final watt = snapshot.data!['watt'] as int;
                      final ampere = snapshot.data!['ampere'] as int;
                      final percentage = snapshot.data!['percentage'] as int;
                      final power = snapshot.data!['power'] as bool;
                      const date = false;
                      // final date = snapshot.data!['date'].toString() == 'true
                      //     ? true
                      //     : false;
                      return buildBox(
                          doc['deviceId'] as String,
                          doc.id,
                          doc['deviceType'] as int,
                          alignment
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          doc['deviceName'] as String,
                          'IOT Device',
                          voltage,
                          watt,
                          ampere,
                          percentage,
                          [date, date, if (power) date else power],
                          // power
                          //     ? date
                          //         ? power
                          //         : date
                          //     : power,

                          () {
                        widgetAlignment = false;
                        setState(() {});
                      });
                    } else {
                      return Container();
                    }
                  },
                );
              }).toList(),
            ),
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
    //       buildBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       rightBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       buildBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //       rightBox("Device 1", "IOT Device", 30, 1, 80, false, true),
    //     ],
    //   ),
    // );
  }

  Widget buildBox(
    String deviceId,
    String dataId,
    int deviceType,
    Alignment align,
    String title,
    String desc,
    double voltage,
    int watt,
    int ampere,
    int percentage,
    List<bool> status,
    VoidCallback callback,
  ) {
    return Padding(
      padding:
          EdgeInsets.only(top: 1.5.w, bottom: 1.w, left: 1.5.w, right: 1.5.w),
      child: GestureDetector(
        onTap: () => Get.toNamed<Object>(
          Routes.deviceDetailPage,
          arguments: [deviceId, deviceType, dataId],
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
                begin: align == Alignment.centerLeft
                    ? Alignment.topRight
                    : Alignment.topLeft,
                end: align == Alignment.centerLeft
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                colors: [
                  Theme.of(Get.context!).colorScheme.tertiary.withOpacity(0.7),
                  Theme.of(Get.context!).colorScheme.tertiary.withOpacity(0.4),
                  Theme.of(Get.context!).colorScheme.tertiary.withOpacity(0.3),
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Image.asset(
                  (status[0] == true)
                      ? 'assets/images/home_battery_icon_online.png'
                      : 'assets/images/home_battery_icon_offline.png',
                  height: 8.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.w),
                child: Text(
                  (status[0] == true) ? '$voltage V' : 'OFFLINE',
                  style: GoogleFonts.inter(
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 30,
                        color: (status[0] == true)
                            ? Theme.of(Get.context!)
                                .colorScheme
                                .primary
                                .withOpacity(0.6)
                            : Theme.of(Get.context!).colorScheme.outline,
                      ),
                    ],
                    color: (status[0] == true)
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Theme.of(Get.context!).colorScheme.outline,
                    fontSize: 6.w,
                    fontWeight: FontWeight.bold,
                  ),
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
                      fontWeight: FontWeight.bold,
                    ),
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
                    '${watt}W ${ampere}A',
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
                            color: (status[1] == true)
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
                            child: (status[1] == true)
                                ? SizedBox(
                                    width: 20.w,
                                    child: Text(
                                      'Charging ½($percentage)',
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
                                      'Charge ½$percentage',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                      child: Transform.scale(
                        scale: 0.9,
                        child: CupertinoSwitch(
                          value: status[2],
                          activeColor: Theme.of(context).colorScheme.tertiary,
                          onChanged: (value) async {
                            if (status[0] == true) {
                              await FirebaseService()
                                  .setDevicePower(deviceId, value ? 0 : -1);
                              callback();
                            } else {
                              Get.snackbar(
                                'Unable to connect to your device',
                                'Please plug in your device.',
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
