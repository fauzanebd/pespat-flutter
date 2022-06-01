import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reservations_controller.dart';

class ReservationsPage extends GetView<ReservationsController> {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Reservations Page'),
      ),
    );
  }
}
