import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pespat/pages/login/model/login_data.dart';
import 'package:pespat/user/model/user.dart';

import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../reservations/reservations_page.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  // LoginData loginData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var loginData = Get.arguments;
    // LoginData loginData = LoginData(
    //   userData: UserData(
    //     lastName: 'koko',
    //     firstName: 'koko',
    //     email: 'koko@gmail.com',
    //     password: 'koko',
    //   ),
    //   success: true,
    //   token: 'mdakld',
    //   message: 'Login successful',
    //   userId: 'wlknqo',
    // );
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(
                  user: User(
                    id: loginData.userId,
                    firstName: loginData.userData?.firstName,
                    lastName: loginData.userData?.lastName,
                    email: loginData.userData?.email,
                    password: loginData.userData?.password,
                  ),
                  token: loginData.token!,
                ),
                ReservationsPage(),
                ProfilePage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.blue,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.house_fill,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.news_solid,
                label: 'Reservations',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person_solid,
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
