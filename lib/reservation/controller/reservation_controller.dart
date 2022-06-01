import 'package:get/get.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';

import '../../common/app_color.dart';
import '../../place/model/place.dart';
import '../../user/model/user.dart';
import '../model/reservation.dart';

class ReservationController extends GetxController {
  ReservationController({required this.user, required this.place});

  final User user;
  final Place place;

  var reservation_date = DateTime.now().obs;
  var is_student = false.obs;

  var reservation = Reservation().obs;

  @override
  void onInit() {
    super.onInit();
    reservation.value.place_id = place.id;
    reservation.value.user_id = user.id;
  }

  void changeReservationDate(DateTime date) {
    reservation_date.value = date;
    update();
  }

  void verifyStudent(User user) {
    is_student.value = true;
    update();
  }

  void payReservation() {
    CustomLoadDialog.showDialog();

    Future.delayed(Duration(seconds: 3), () {
      // Get.snackbar(
      //   'Reservation',
      //   'Reservation has been made successfully',
      //   backgroundColor: AppColor.green100,
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 2),
      // );
      CustomLoadDialog.cancelDialog();
    });
  }
}
