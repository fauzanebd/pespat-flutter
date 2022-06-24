import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../common/app_color.dart';
import '../../common/app_font.dart';
import '../../place/model/place.dart';
import '../../place/view/place_details.dart';
import '../../user/model/user.dart';
import '../home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({
    // required this.user_name,
    // required this.user_id,
    required this.token,
    required this.user,
  });
  // final String user_name;
  // final String user_id;
  final String token;
  final User user;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );

    final appBarPespat = AppBar(
      backgroundColor: Color(0xFFFFF6E5),
      // title: SvgPicture.asset('assets/icons/cape_logo.svg'),
      elevation: 0,
      leading: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Center(
          child: TextButton(
            onPressed: () {
              // print("pergi ke profile");
              // print(user.photoURL);
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://e7.pngegg.com/pngimages/92/781/png-clipart-computer-icons-user-profile-avatar-avatar-heroes-profile-thumbnail.png",
              ),
            ),
          ),
          // child: const Icon(
          //   CupertinoIcons.person_alt_circle,
          //   color: AppColor.dark100,
          //   size: 40,
          // ),
        ),
      ),
      leadingWidth: 70.w,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            flex: 10,
            child: SizedBox(),
          ),
          SvgPicture.asset(
            'assets/icons/pespat_logo.svg',
            fit: BoxFit.scaleDown,
          ),
          const Expanded(
            flex: 0,
            child: SizedBox(),
          ),
        ],
      ),
      centerTitle: true,
    );

    return GetBuilder<HomeController>(
      builder: (controller) {
        return ScreenTypeLayout(
          breakpoints:
              const ScreenBreakpoints(tablet: 600, desktop: 950, watch: 300),
          mobile: Scaffold(
            backgroundColor: AppColor.light100,
            appBar: appBarPespat,
            body: RefreshIndicator(
              onRefresh: () async {
                // await Future.delayed(Duration(seconds: 1));
                // await controller.getPlaces();
                await controller.fetchPlaces();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    HeaderWidget(
                      fullName: "${user.firstName} ${user.lastName}",
                    ),
                    TitleOfSubElement(
                      title: "Featured Places",
                      onSeeAll: () {
                        print("see all");
                      },
                      disableSeeAllButton: true,
                    ),
                    PlaceListView(
                      placeList: controller.placeList,
                      user: user,
                      token: token,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    this.fullName = '',
  }) : super(key: key);

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 9.w),
      child: Container(
        width: double.infinity,
        height: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.w),
            bottomRight: Radius.circular(24.w),
          ),
          color: Color(0xFFFFF6E5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.w,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20.w,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, ",
                        style: AppFont.body3(
                            fontSize: 14.sp, fontColor: AppColor.light20),
                      ),
                      Text(
                        fullName,
                        style: AppFont.title2(
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const Expanded(child: SizedBox()),
            SearchBox(
              hint: "Search for places...",
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.hint = '',
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.light20,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16.w),
          color: AppColor.light100,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Icon(
              CupertinoIcons.search,
              color: AppColor.dark100,
              size: 20,
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleOfSubElement extends StatelessWidget {
  const TitleOfSubElement({
    Key? key,
    required this.title,
    required this.onSeeAll,
    this.disableSeeAllButton = false,
  }) : super(key: key);

  final String title;
  final onSeeAll;
  final bool disableSeeAllButton;

  @override
  Widget build(BuildContext context) {
    late Widget titleWidget;
    if (!disableSeeAllButton) {
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
          top: 9.w,
          bottom: 9.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: AppFont.title3(fontSize: 18.sp),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(32.w),
              child: Container(
                width: 78,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColor.violet20,
                ),
                child: TextButton(
                  onPressed: () {
                    onSeeAll();
                  },
                  child: Center(
                    child: Text(
                      "See All",
                      style: AppFont.body2(
                        fontSize: 14.sp,
                        fontColor: AppColor.blue100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
          top: 9.w,
          bottom: 9.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: AppFont.title3(fontSize: 18.sp),
            ),
            Expanded(child: SizedBox())
          ],
        ),
      );
    }
    return titleWidget;
  }
}

class PlaceListView extends StatelessWidget {
  PlaceListView({
    Key? key,
    required this.placeList,
    required this.user,
    required this.token,
  }) : super(key: key);

  final List<Place> placeList;
  final User user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: placeList.length,
      padding: EdgeInsets.only(top: 10.w),
      itemBuilder: (context, index) {
        return PlaceItem(
          place: placeList[index],
          user: user,
          token: token,
        );
      },
    );
  }
}

class PlaceItem extends StatelessWidget {
  const PlaceItem({
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
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.w,
          ),
          elevation: 5.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.zero,
                    width: 100.w,
                    height: 120.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(place.photo!),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    height: 100.w,
                    width: 240.w,
                    padding: EdgeInsets.only(
                      top: 10.w,
                      bottom: 10.w,
                      right: 10.w,
                      left: 10.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          place.name!,
                          style: AppFont.body2(fontSize: 16.sp),
                        ),
                        Text(
                          place.details!,
                          style: AppFont.body1(
                              fontSize: 12.sp, fontColor: AppColor.light20),
                          overflow: TextOverflow.fade,
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 160.w,
                              child: Text(
                                place.address!,
                                style: AppFont.body3(fontSize: 10.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: 60.w,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Rp. ${place.price!}",
                                  style: AppFont.body3(fontSize: 10.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          left: 10.w,
          right: 10.w,
          top: 5.w,
          bottom: 5.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Get.to(PlaceDetails(), arguments: place);
                  Get.to(
                    () => const PlaceDetails(),
                    arguments: [user, place, token],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
