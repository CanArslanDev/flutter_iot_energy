import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditScenePage extends StatelessWidget {
  const EditScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: backgroundDecoration,
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
