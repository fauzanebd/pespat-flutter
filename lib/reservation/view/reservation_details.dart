import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pespat/common/app_color.dart';
import 'package:pespat/common/app_font.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/reservation_details_controller.dart';

class ReservationStatusDetails extends GetView<ReservationDetailsController> {
  final String reservationId = Get.arguments[0];
  final String placeName = Get.arguments[1];
  final String reservationDate = Get.arguments[2];
  final String payStatus = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
    );

    return GetBuilder<ReservationDetailsController>(
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
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200.w,
                    color: AppColor.blue100,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.w),
                        child: Text("Reservation Status",
                            style:
                                AppFont.title1(fontColor: AppColor.light100)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  ReservationStatus(
                    reservationId: reservationId,
                    placeName: placeName,
                    reservationDate: reservationDate,
                    payStatus: payStatus,
                    reservationDetailsController: controller,
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

class ReservationStatus extends StatelessWidget {
  const ReservationStatus({
    required this.reservationId,
    required this.placeName,
    required this.reservationDate,
    required this.payStatus,
    required this.reservationDetailsController,
  });

  final ReservationDetailsController reservationDetailsController;
  final String reservationId;
  final String placeName;
  final String reservationDate;
  final String payStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: AppColor.light100,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Text("Reservation ID: $reservationId",
                      style: AppFont.body1()),
                  SizedBox(height: 10.w),
                  Text(
                    "Place Name: $placeName",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    "Reservation Date: $reservationDate",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    "Payment Status: $payStatus",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.w),
                ],
              ),
              Container(
                height: 300.w,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Click this button to go to payment page",
                      style: AppFont.body1(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                        fixedSize: Size(
                          300.w,
                          60.w,
                        ),
                        primary: AppColor.blue100,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.w),
                      ),
                      onPressed: () async {
                        await reservationDetailsController.goToPaymentPage();
                      },
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          color: AppColor.light100,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      "Return to this app after payment success to get your invoice",
                      style: AppFont.body1(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                        fixedSize: Size(
                          300.w,
                          60.w,
                        ),
                        primary: AppColor.blue100,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.w),
                      ),
                      onPressed: () async {
                        // getting invoice
                        // await reservationDetailsController.goToPaymentPage();
                        await reservationDetailsController.getInvoice();
                      },
                      child: Text(
                        'Get Invoice',
                        style: TextStyle(
                          color: AppColor.light100,
                        ),
                      ),
                    ),
                  ],
                ),
                // child: Obx(
                //   () {
                //     if (reservationDetailsController.reservation_status.value ==
                //         'paid') {
                //       return ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16.w),
                //           ),
                //           fixedSize: Size(
                //             300.w,
                //             60.w,
                //           ),
                //           primary: AppColor.blue100,
                //           padding: EdgeInsets.symmetric(
                //               horizontal: 16.w, vertical: 16.w),
                //         ),
                //         onPressed: () {
                //           // getting invoice
                //         },
                //         child: Text(
                //           'Get Invoice',
                //           style: TextStyle(
                //             color: AppColor.light100,
                //           ),
                //         ),
                //       );
                //     } else {
                //       return Column(
                //         children: <Widget>[
                //           Text(
                //             "Click this button to go to payment page",
                //             style: AppFont.body1(),
                //           ),
                //           ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(16.w),
                //               ),
                //               fixedSize: Size(
                //                 300.w,
                //                 60.w,
                //               ),
                //               primary: AppColor.blue100,
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 16.w, vertical: 16.w),
                //             ),
                //             onPressed: () async {
                //               var url =
                //                   "http://pay-kuy.herokuapp.com/bayar/${reservationDetailsController.paymentId}";
                //               if (await canLaunchUrl(Uri.parse(url))) {
                //                 await launchUrl(
                //                   Uri.parse(url),
                //                   mode: LaunchMode.externalApplication,
                //                 );
                //               } else {
                //                 throw 'Could not launch $url';
                //               }
                //             },
                //             child: Text(
                //               'Pay Now',
                //               style: TextStyle(
                //                 color: AppColor.light100,
                //               ),
                //             ),
                //           ),
                //           SizedBox(height: 10.w),
                //           Text(
                //             "Return to this app after payment success to get your invoice",
                //             style: AppFont.body1(),
                //           ),
                //         ],
                //       );
                //     }
                //   },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
