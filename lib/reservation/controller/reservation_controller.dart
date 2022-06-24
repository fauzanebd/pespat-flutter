import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/api/api_service.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';
import 'package:pespat/payment/model/payment_info.dart';
import 'package:pespat/reservation/controller/reservation_details_controller.dart';
import 'package:pespat/reservation/model/reservation_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_color.dart';
import '../../place/model/place.dart';
import '../../routes/app_pages.dart';
import '../../user/model/user.dart';
import '../bindings/reservation_details_bindings.dart';
import '../model/reservation.dart';
import '../view/reservation_details.dart';

class ReservationController extends GetxController {
  ReservationController(
      {required this.user, required this.place, required this.token});

  final User user;
  final Place place;
  final String token;

  var paymentInfo = PaymentInfo().obs;
  var reservationData = ReservationData().obs;

  var reservation_date = DateTime.now().obs;
  var is_student = false.obs;

  var reservation = Reservation().obs;

  @override
  void onInit() {
    super.onInit();
    reservation.value.placeId = place.id;
    reservation.value.userId = user.id;
  }

  void changeReservationDate(DateTime date) {
    reservation_date.value = date;
    update();
  }

  Future<void> verifyStudent(User user, String token) async {
    CustomLoadDialog.showDialog(barrierColor: Colors.black.withOpacity(0.5));
    var isStudent = await ApiService.verifyStudent(user.id!, token);
    CustomLoadDialog.cancelDialog();
    is_student.value = isStudent!;
    // show snackbar informing about user status
    Get.snackbar(
      'Status',
      isStudent
          ? 'Anda sudah terdaftar sebagai mahasiswa'
          : 'Anda belum terdaftar sebagai mahasiswa',
      duration: Duration(seconds: 3),
      backgroundColor: isStudent ? AppColor.green100 : AppColor.red100,
      colorText: Colors.white,
    );

    update();
  }

  Future<void> createReservation() async {
    CustomLoadDialog.showDialog(barrierColor: Colors.black.withOpacity(0.5));
    try {
      reservationData.value = (await ApiService.createReservation(
        userId: user.id!,
        placeId: place.id!,
        reservationTime: reservation_date.toString(),
        status: 'pending',
        token: token,
      ))!;
      if (reservation != null) {
        CustomLoadDialog.cancelDialog();
        await payReservation(
            reservationData.value.reservationId!, place.price!);
        // Get.offAllNamed(Routes.DASHBOARD, arguments: user);
      } else {
        Get.snackbar(
          'Reservation Failed',
          'Please check your credentials',
          icon: Icon(Icons.error),
          backgroundColor: AppColor.red100,
        );
      }
    } finally {
      CustomLoadDialog.cancelDialog();
    }
  }

  Future<void> payReservation(String? reservationId, int price) async {
    CustomLoadDialog.showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
    );
    var paymentData = await ApiService.createPayment(
      reservationId: reservationId!,
      totalPrice: price,
    );
    if (paymentData != null) {
      paymentInfo.value = (await ApiService.getPaymentInfo(reservationId))!;
      // if (paymentInfo != null) {
      //   // tampilin url buat bayar
      //   // print(paymentInfo.id);
      //   // Get.put<ReservationDetailsController>(
      //   //   ReservationDetailsController(
      //   //     paymentId: paymentInfo.value.id!,
      //   //     reservationId: reservationId,
      //   //     // reservationDate: reservation.value.reservationTime!,
      //   //     reservationPrice: place.price.toString(),
      //   //     placeName: place.name!,
      //   //     userEmail: user.email!,
      //   //     userName: "${user.firstName} ${user.lastName}",
      //   //   ),
      //   // );
      //   // ReservationStatusDetailsBindings(
      //   //   paymentId: paymentInfo.value.id!,
      //   //   reservationId: reservationId,
      //   //   // reservationDate: reservation.value.reservationTime!,
      //   //   reservationPrice: place.price.toString(),
      //   //   placeName: place.name!,
      //   //   userEmail: user.email!,
      //   //   userName: "${user.firstName} ${user.lastName}",
      //   // ).dependencies();
      //   // Get.to(() => ReservationStatusDetails(),
      //   //     arguments: [
      //   //       reservationId,
      //   //       place.name!,
      //   //       reservation_date.value.toString(),
      //   //       'pending',
      //   //     ],
      //   //     binding: ReservationStatusDetailsBindings(
      //   //       paymentId: paymentInfo.value.id!,
      //   //       reservationId: reservationId,
      //   //       // reservationDate: reservation.value.reservationTime!,
      //   //       reservationPrice: place.price.toString(),
      //   //       placeName: place.name!,
      //   //       userEmail: user.email!,
      //   //       userName: "${user.firstName} ${user.lastName}",
      //   //     ));
      // }
      // CustomLoadDialog.cancelDialog();
    } else {
      CustomLoadDialog.cancelDialog();
      Get.snackbar(
        'Payment Failed',
        'Please check your credentials',
        icon: Icon(Icons.error),
        backgroundColor: AppColor.red100,
      );
    }
  }
}
