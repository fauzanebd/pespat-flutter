import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';
import 'package:pespat/pages/register/model/register_data.dart';

import '../../../api/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../login/model/login_data.dart';

class RegisterController extends GetxController {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  Rx<String> firstName = ''.obs;
  Rx<String> lastName = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;

  late RegisterData registerData;
  late LoginData? loginData;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    print(
      "signing in with firstName: ${firstName} and lastName: ${lastName} and email: ${email} and password: ${password}",
    );
    CustomLoadDialog.showDialog();
    try {
      var registerData =
          await ApiService.register(firstName, lastName, email, password);
      if (registerData != null) {
        this.registerData = registerData;

        this.loginData = await ApiService.login(email, password);
        if (loginData != null) {
          CustomLoadDialog.cancelDialog();
          Get.offAllNamed(Routes.DASHBOARD, arguments: loginData);
        } else {
          CustomLoadDialog.cancelDialog();
          Get.snackbar(
            'Login Failed',
            'Please check your credentials',
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
          );
        }
      } else {
        CustomLoadDialog.cancelDialog();
        Get.snackbar(
          'Register Failed: ',
          'Please check your credentials',
          icon: Icon(Icons.error),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      CustomLoadDialog.cancelDialog();
      Get.snackbar(
        'Register Failed: ',
        e.toString(),
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
      );
    }
  }
}
