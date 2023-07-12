import 'package:flutter/material.dart';
import 'package:get/get.dart';

///showInformationSnackbar
void showInformationSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    borderColor: const Color(0xFFFF3300),
    borderWidth: 1,
    backgroundColor:
        Theme.of(Get.context!).colorScheme.background.withOpacity(0.7),
  );
}
