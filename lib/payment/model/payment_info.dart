// To parse this JSON data, do
//
//     final paymentInfo = paymentInfoFromJson(jsonString);

import 'dart:convert';

List<PaymentInfo> paymentInfoListFromJson(String str) => List<PaymentInfo>.from(
    json.decode(str).map((x) => PaymentInfo.fromJson(x)));

String paymentInfoToJson(List<PaymentInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentInfo {
  PaymentInfo({
    this.id,
    this.totalPrice,
    this.expDate,
    this.status,
    this.foreignId,
    this.v,
  });

  String? id;
  String? totalPrice;
  DateTime? expDate;
  bool? status;
  String? foreignId;
  int? v;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        id: json["_id"],
        totalPrice: json["totalPrice"],
        expDate: DateTime.parse(json["expDate"]),
        status: json["status"],
        foreignId: json["foreignId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalPrice": totalPrice,
        "expDate": expDate?.toIso8601String(),
        "status": status,
        "foreignId": foreignId,
        "__v": v,
      };
}
