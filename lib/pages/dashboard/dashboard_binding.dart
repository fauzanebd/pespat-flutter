import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../profile/profile_controller.dart';
import '../reservations/reservations_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<HomeController>(HomeController());
    Get.put<ReservationsController>(ReservationsController());
    Get.put<ProfileController>(ProfileController());
  }
}
