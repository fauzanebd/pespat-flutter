import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pespat/common/views/custom_load_dialog.dart';
import 'package:pespat/reservation/controller/reservation_controller.dart';
import 'package:pespat/reservation/view/reservation_details.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_color.dart';
import '../../common/app_font.dart';
import '../../payment/model/payment.dart';
import '../../place/model/place.dart';
import '../../user/model/user.dart';
import '../bindings/reservation_details_bindings.dart';
import '../controller/reservation_details_controller.dart';
import '../model/reservation.dart';

class MakeReservation extends GetView<ReservationController> {
  // final ReservationController reservationController;
  MakeReservation({
    Key? key,
    // required this.reservationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = Get.arguments[0];
    User user = Get.arguments[1];
    String token = Get.arguments[2];
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
    );

    return GetBuilder<ReservationController>(
      builder: (controller) {
        return ScreenTypeLayout(
          breakpoints: ScreenBreakpoints(
            tablet: 600,
            desktop: 950,
            watch: 300,
          ),
          mobile: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        ReservationDetails(
                          reservationController: controller,
                          place: place,
                          user: user,
                        ),
                        StudentVerification(
                          reservationController: controller,
                          place: place,
                          user: user,
                          token: token,
                        ),
                      ],
                      // PayButton(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: PaymentButton(
                        reservation: controller.reservation.value,
                        reservationController: controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReservationDetails extends StatelessWidget {
  const ReservationDetails({
    Key? key,
    required this.reservationController,
    required this.place,
    required this.user,
  }) : super(key: key);

  final ReservationController reservationController;
  final Place place;
  final User user;

  @override
  Widget build(BuildContext context) {
    Reservation reservation = Reservation();
    // DateTime timePicked = DateTime.now();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 32.w,
              left: 16.w,
              right: 16.w,
              bottom: 8.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Reservation Details: ",
                style: AppFont.title3(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 0.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Place: ${place.name}",
                    style: AppFont.body1(
                      fontColor: AppColor.light20,
                    ),
                  ),
                  Text(
                    "Address: ${place.address}",
                    style: AppFont.body1(
                      fontColor: AppColor.light20,
                    ),
                  ),
                  Text(
                    "Pick date for your reservation: ",
                    style: AppFont.body1(
                      fontColor: AppColor.light20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2022, 6, 1),
                        maxTime: DateTime(2025, 6, 7),
                        onChanged: (date) {
                          // reservation.reservation_time = date;
                        },
                        onConfirm: (date) {
                          // timePicked = date;
                          // reservationController.reservation_date.value = date;
                          var originDate =
                              reservationController.reservation_date.value;
                          var pickedDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            reservationController.reservation_date.value.hour,
                            reservationController.reservation_date.value.minute,
                          );
                          reservationController.changeReservationDate(date);
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.id,
                      );
                    },
                    child: Text(
                      'Pick date for reservation',
                      style: AppFont.body1(
                        fontColor: AppColor.blue100,
                      ),
                    ),
                  ),
                  Text(
                    "Date: ${reservationController.reservation_date.value.year}/${reservationController.reservation_date.value.month}/${reservationController.reservation_date.value.day}",
                    style: AppFont.body1(
                      fontColor: AppColor.light20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showTimePicker(
                        context,
                        onChanged: (time) {},
                        onConfirm: (time) {
                          var datepicked = DateTime(
                            reservationController.reservation_date.value.year,
                            reservationController.reservation_date.value.month,
                            reservationController.reservation_date.value.day,
                            time.hour,
                            time.minute,
                          );
                          reservationController
                              .changeReservationDate(datepicked);
                        },
                      );
                    },
                    child: Text(
                      'Pick time for reservation',
                      style: AppFont.body1(
                        fontColor: AppColor.blue100,
                      ),
                    ),
                  ),
                  Text(
                    "Time: ${reservationController.reservation_date.value.hour}:${reservationController.reservation_date.value.minute}",
                    style: AppFont.body1(
                      fontColor: AppColor.light20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentVerification extends StatelessWidget {
  const StudentVerification({
    Key? key,
    required this.reservationController,
    required this.place,
    required this.user,
    required this.token,
  }) : super(key: key);

  final ReservationController reservationController;
  final Place place;
  final User user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 2.w,
            ),
            child: Text(
              "Are you a student? verify your student ID to get discount",
              style: AppFont.body1(
                fontColor: AppColor.light20,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // var url = "https://ugm-auth.vercel.app/login";
              // if (await canLaunch(url)) {
              //   await launch(url);
              // } else {
              //   throw 'Could not launch $url';
              // }
              await reservationController.verifyStudent(user, token);
            },
            child: Text(
              'Verify',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          // return congrats! student promo applied if verified
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.reservation,
    required this.reservationController,
    // required this.payment,
  }) : super(key: key);

  final Reservation reservation;
  final ReservationController reservationController;
  // final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10.w,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColor.light100,
                // border only top side
                border: Border(
                  top: BorderSide(
                    color: AppColor.light20,
                    width: 1.w,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.w),
                ),
                fixedSize: Size(
                  300.w,
                  60.w,
                ),
                primary: AppColor.blue100,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
              ),
              onPressed: () async {
                await reservationController.createReservation();
                // CustomLoadDialog.showDialog(
                //   barrierColor: Colors.black.withOpacity(0.5),
                // );

                ReservationStatusDetailsBindings(
                  paymentId: reservationController.paymentInfo.value.id!,
                  reservationId: reservationController
                      .reservationData.value.reservationId!,
                  // reservationDate: reservation.value.reservationTime!,
                  reservationPrice:
                      reservationController.place.price.toString(),
                  placeName: reservationController.place.name!,
                  userEmail: reservationController.user.email!,
                  userName:
                      "${reservationController.user.firstName} ${reservationController.user.lastName}",
                ).dependencies();
                Get.to(
                  () => ReservationStatusDetails(),
                  arguments: [
                    reservationController.reservationData.value.reservationId!,
                    reservationController.place.name!,
                    reservationController.reservation_date.value.toString(),
                    'pending',
                  ],
                  binding: ReservationStatusDetailsBindings(
                    paymentId: reservationController.paymentInfo.value.id!,
                    reservationId: reservationController
                        .reservationData.value.reservationId!,
                    // reservationDate: reservation.value.reservationTime!,
                    reservationPrice:
                        reservationController.place.price.toString(),
                    placeName: reservationController.place.name!,
                    userEmail: reservationController.user.email!,
                    userName:
                        "${reservationController.user.firstName} ${reservationController.user.lastName}",
                  ),
                  preventDuplicates: true,
                );
                // CustomLoadDialog.cancelDialog();
              },
              child: Text(
                'Pay',
                style: AppFont.title3(
                  fontColor: AppColor.light100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
