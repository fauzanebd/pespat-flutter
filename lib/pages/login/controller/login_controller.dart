import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';
import 'package:pespat/pages/login/model/login_data.dart';

import '../../../api/api_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;

  late LoginData loginData;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // print(
    //   "signing in with email: ${email} and password: ${password}",
    // );

    CustomLoadDialog.showDialog();
    try {
      var loginData = await ApiService.login(email, password);
      if (loginData != null) {
        this.loginData = loginData;
        // print(loginData);

        Get.offAllNamed(Routes.DASHBOARD, arguments: loginData);
        CustomLoadDialog.cancelDialog();
      } else {
        CustomLoadDialog.cancelDialog();
        Get.snackbar(
          'Login Failed',
          'Please check your credentials',
          icon: Icon(Icons.error),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      CustomLoadDialog.cancelDialog();
      Get.snackbar(
        'Login Failed',
        e.toString(),
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
      );
    }
  }
}
