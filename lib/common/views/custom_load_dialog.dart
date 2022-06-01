import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/common/app_color.dart';

class CustomLoadDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.light100),
            ),
          ),
        ),
        onWillPop: () async => false,
      ),
      barrierDismissible: false,
      barrierColor: AppColor.blue100,
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
