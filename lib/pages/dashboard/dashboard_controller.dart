import 'package:get/get.dart';

class DashboardController extends GetxController {
  final String title = 'Home Page';

  @override
  void onInit() {
    super.onInit();
    // user = Get.arguments;
  }

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
