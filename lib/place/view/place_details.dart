import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pespat/common/app_font.dart';
import 'package:pespat/place/model/place.dart';
import 'package:pespat/reservation/controller/reservation_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../common/app_color.dart';
import '../../reservation/view/make_reservation.dart';
import '../../user/model/user.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({Key? key}) : super(key: key);

  // final Place place;

  @override
  Widget build(BuildContext context) {
    // User user = User(
    //   id: '1',
    //   firstName: 'John',
    //   lastName: 'Doe',
    //   email: 'johndoe@ymail.com',
    //   password: '123456',
    // );
    var user = Get.arguments[0];
    var place = Get.arguments[1];
    var token = Get.arguments[2];
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
    );

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
              PlaceDetailsHeader(
                photo: place.photo!,
                title: place.name!,
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 360.w,
                    child: Column(
                      children: [
                        PlaceDetailsContent(
                          address: place.address!,
                          details: place.details!,
                          price: place.price!,
                        ),
                        Expanded(child: SizedBox()),
                        SizedBox(height: 8.w),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 360.w,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ReservationButton(
                        place: place,
                        user: user,
                        token: token,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceDetailsHeader extends StatelessWidget {
  const PlaceDetailsHeader({
    Key? key,
    required this.photo,
    required this.title,
  }) : super(key: key);

  final String photo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.w,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 260.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(photo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    Colors.black
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.w,
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceDetailsContent extends StatelessWidget {
  const PlaceDetailsContent({
    Key? key,
    required this.address,
    required this.details,
    required this.price,
  }) : super(key: key);

  final String address;
  final String details;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 16.w,
              left: 16.w,
              right: 16.w,
              bottom: 8.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Details",
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
              child: Text(
                details,
                style: AppFont.body1(
                  fontColor: AppColor.light20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 16.w,
              left: 16.w,
              right: 16.w,
              bottom: 8.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Address",
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
              child: Text(
                address,
                style: AppFont.body1(
                  fontColor: AppColor.light20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 16.w,
              left: 16.w,
              right: 16.w,
              bottom: 8.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Price",
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
              child: Text(
                "Rp. $price",
                style: AppFont.body1(
                  fontColor: AppColor.light20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationButton extends StatelessWidget {
  const ReservationButton({
    Key? key,
    required this.place,
    required this.user,
    required this.token,
  }) : super(key: key);

  final Place place;
  final User user;
  final String token;

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
              onPressed: () {
                // ReservationController reservationController =
                //     Get.put(ReservationController());
                Get.put<ReservationController>(ReservationController(
                  place: place,
                  user: user,
                  token: token,
                ));
                Get.to(() => MakeReservation(),
                    arguments: [place, user, token]);
              },
              child: Text(
                'Book this place',
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
