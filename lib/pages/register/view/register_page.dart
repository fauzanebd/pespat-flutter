import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pespat/common/app_color.dart';
import 'package:pespat/routes/app_pages.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
    );
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(tablet: 600, desktop: 950, watch: 300),
      mobile: Scaffold(
        backgroundColor: AppColor.light100,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  SvgPicture.asset(
                    'assets/icons/pespat_logo.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.firstNameController.value,
                    onChanged: (val) {
                      controller.email.value = val;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.lastNameController.value,
                    onChanged: (val) {
                      controller.lastName.value = val;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.emailController.value,
                    onChanged: (val) {
                      controller.email.value = val;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.passwordController.value,
                    onChanged: (val) {
                      controller.password.value = val;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColor.blue100,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.blue100,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            // print(
                            //   "signing up with email: ${controller.email.value} and password: ${controller.password.value}",
                            // );
                            controller.register(
                              firstName:
                                  controller.firstNameController.value.text,
                              lastName:
                                  controller.lastNameController.value.text,
                              email: controller.emailController.value.text,
                              password:
                                  controller.passwordController.value.text,
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: AppColor.blue100,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: AppColor.blue100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
