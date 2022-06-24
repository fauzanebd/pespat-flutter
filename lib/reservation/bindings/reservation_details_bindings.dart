import 'package:get/get.dart';
import 'package:pespat/reservation/controller/reservation_details_controller.dart';

class ReservationStatusDetailsBindings extends Bindings {
  ReservationStatusDetailsBindings({
    required this.paymentId,
    required this.reservationId,
    // required this.reservationDate,
    required this.reservationPrice,
    required this.placeName,
    required this.userEmail,
    required this.userName,
  });

  final String paymentId;
  final String reservationId;
  // final String reservationDate;
  final String reservationPrice;
  final String placeName;
  final String userEmail;
  final String userName;

  @override
  void dependencies() {
    Get.put<ReservationDetailsController>(
      ReservationDetailsController(
        paymentId: paymentId,
        reservationId: reservationId,
        // reservationDate: reservationDate,
        reservationPrice: reservationPrice,
        placeName: placeName,
        userEmail: userEmail,
        userName: userName,
      ),
    );
  }
}
