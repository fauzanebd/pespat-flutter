import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/common/app_color.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api_service.dart';

class ReservationDetailsController extends GetxController {
  ReservationDetailsController({
    required this.paymentId,
    required this.reservationId,
    // required this.reservationDate,
    required this.reservationPrice,
    required this.placeName,
    required this.userEmail,
    required this.userName,
  });

  var reservation_status = 'pending'.obs;
  Rx<bool> payment_status = false.obs;
  final String paymentId;
  final String reservationId;
  // final String reservationDate;
  final String reservationPrice;
  final String placeName;
  final String userEmail;
  final String userName;

  @override
  void onInit() {
    super.onInit();
    checkReservationStatus(reservationId);
  }

  // @override
  // void onDelete() {
  //   // print why this controller is deleted
  //   super.onDelete();
  //   print('ReservationDetailsController deleted');
  // }

  void changeReservationStatus(String status) {
    reservation_status.value = status;
    update();
  }

  void checkReservationStatus(String id) {
    ApiService.getPaymentStatus(id).then(
      (value) {
        if (value == true) {
          payment_status.value = true;
          changeReservationStatus('paid');
        }
      },
    );
  }

  Future<void> goToPaymentPage() async {
    var url = "http://pay-kuy.herokuapp.com/bayar/${paymentId}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getInvoice() async {
    CustomLoadDialog.showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
    );
    var isSent = await ApiService.sendInvoiceToEmail(
      username: userName,
      useremail: userEmail,
      placeName: placeName,
      price: reservationPrice,
      paymentNumber: paymentId,
      date: "2022-06-02T01:25:23.604Z",
    );
    CustomLoadDialog.cancelDialog();

    // pop get snackbar if invoice is sent
    if (isSent == true) {
      Get.snackbar(
        'Invoice',
        'Invoice has been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.green100,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Invoice',
        'Invoice has not been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.red100,
        duration: Duration(seconds: 2),
      );
    }
  }
}
