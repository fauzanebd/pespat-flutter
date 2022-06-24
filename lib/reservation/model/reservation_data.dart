// To parse this JSON data, do
//
//     final reservationData = reservationDataFromJson(jsonString);

import 'dart:convert';

ReservationData reservationDataFromJson(String str) =>
    ReservationData.fromJson(json.decode(str));

String reservationDataToJson(ReservationData data) =>
    json.encode(data.toJson());

class ReservationData {
  ReservationData({
    this.message,
    this.reservationId,
  });

  String? message;
  String? reservationId;

  factory ReservationData.fromJson(Map<String, dynamic> json) =>
      ReservationData(
        message: json["message"],
        reservationId: json["reservation_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "reservation_id": reservationId,
      };
}
