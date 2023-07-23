import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void dialogInformation(BuildContext context, String title, String description) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 60.w,
          width: 60.w,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(30),
            border: GradientBoxBorder(
              width: 3,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).colorScheme.primary, Colors.white],
              ),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.w, left: 2.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.none,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 6.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.w, left: 2.w),
                        child: SizedBox(
                          width: 50.w,
                          child: Text(
                            description,
                            style: GoogleFonts.inter(
                              decoration: TextDecoration.none,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 4.w,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: Get.back<Object>,
                  child: Container(
                    height: 10.w,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Okay',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          decoration: TextDecoration.none,
                          color: Colors.white70,
                          fontSize: 4.w,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return FadeTransition(
        opacity: anim,
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
