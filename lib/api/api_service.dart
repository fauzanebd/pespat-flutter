import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pespat/pages/login/model/login_data.dart';
import 'package:pespat/payment/model/payment_data.dart';
import 'package:pespat/reservation/model/reservation_data.dart';

import '../pages/register/model/register_data.dart';
import '../payment/model/payment_info.dart';
import '../place/model/place.dart';
import '../reservation/model/reservation.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<Place>?> fetchPlaces() async {
    var response = await client.get(
      Uri.parse('https://pespat-be.herokuapp.com/api/places'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return placeListFromJson(jsonString);
    }
  }

  //login
  static Future<LoginData?> login(String email, String password) async {
    var response = await client.post(
      Uri.parse('https://pespat-be.herokuapp.com/api/users/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return loginDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  //register
  static Future<RegisterData?> register(
      String firstName, String lastName, String email, String password) async {
    var response = await client.post(
      Uri.parse('https://pespat-be.herokuapp.com/api/users/register'),
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': password,
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return registerDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  //create reservations
  static Future<ReservationData?> createReservation(
      {required String userId,
      required String placeId,
      required String reservationTime,
      required String status,
      required String token}) async {
    var response = await client.post(
      Uri.parse('https://pespat-be.herokuapp.com/api/reservations'),
      body: {
        'user_id': userId,
        'place_id': placeId,
        'reservation_time': reservationTime,
        'status': status,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return reservationDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  //get reservations by reservation id
  static Future<Reservation?> getReservation(
      String reservationId, String token) async {
    var response = await client.get(
      Uri.parse(
          'https://pespat-be.herokuapp.com/api/reservations/$reservationId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return reservationFromJson(jsonString);
    } else {
      return null;
    }
  }

  //paykuy create payment
  static Future<PaymentData?> createPayment(
      {required String reservationId, required int totalPrice}) async {
    var response = await client.post(
      Uri.parse('https://pay-kuy.herokuapp.com/transaction/add'),
      body: {
        'totalPrice': totalPrice.toString(),
        'id': reservationId,
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return paymentDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  // paykuy get payment id
  static Future<PaymentInfo?> getPaymentInfo(String reservationId) async {
    var response = await client.get(
      Uri.parse('https://pay-kuy.herokuapp.com/transaction/$reservationId'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return paymentInfoListFromJson(jsonString)[0];
    } else {
      return null;
    }
  }

  // paykuy get payment status
  static Future<bool?> getPaymentStatus(String paymentId) async {
    var response = await client.get(
      Uri.parse('https://pay-kuy.herokuapp.com/transaction/$paymentId'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return paymentInfoListFromJson(jsonString)[0].status;
    } else {
      return null;
    }
  }

  static Future<bool?> sendInvoiceToEmail({
    required String username,
    required String placeName,
    required String price,
    required String paymentNumber,
    required String date,
    required String useremail,
  }) async {
    var address = "Jl. Kaliurang Km. 9";

    Map data = {
      "qrData": "",
      "username": username,
      "address": "",
      "email": useremail,
      "phoneNumber": "088912312342",
      "paymentNumber": paymentNumber,
      "item": [
        {
          "count": 2,
          "title": placeName,
          "price": price,
          "date": date.toString(),
        }
      ]
    };

    var body = json.encode(data);
    var response = await client.post(
      Uri.parse('https://pespat-server.herokuapp.com/send-invoice'),
      body: body,
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return true;
    } else {
      return true;
    }
  }

  static Future<bool?> verifyStudent(String user_id, String token) async {
    var response = await client.get(
      Uri.parse(
          'https://pespat-be.herokuapp.com/api/ugm-link/users/$user_id/ugm-data'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return true;
    } else {
      return false;
    }
  }
}
