// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

List<Reservation> reservationListFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  Reservation({
    this.userId,
    this.reservationTime,
    this.placeId,
    this.status,
  });

  String? userId;
  String? reservationTime;
  String? placeId;
  String? status;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        userId: json["userId"],
        reservationTime: json["reservation_time"],
        placeId: json["place_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "reservation_time": reservationTime,
        "place_id": placeId,
        "status": status,
      };
}
