// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final pageTitleColor =
    Theme.of(Get.context!).colorScheme.secondary.withOpacity(0.7);
final pageTitleTextStyle = GoogleFonts.inter(
  color: pageTitleColor,
  fontSize: 7.w,
  fontWeight: FontWeight.bold,
);
final pageDescriptionTextStyle = GoogleFonts.inter(
  color: Theme.of(Get.context!).colorScheme.onTertiary.withOpacity(0.7),
  fontSize: 7.w,
  fontWeight: FontWeight.bold,
);
