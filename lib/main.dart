import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/pages/dashboard/dashboard_binding.dart';

import 'routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // LoadAuthBinding().dependencies();
  // DashboardBinding().dependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PesPat",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
