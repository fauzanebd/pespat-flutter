// To parse this JSON data, do
//
//     final paymentData = paymentDataFromJson(jsonString);

import 'dart:convert';

PaymentData paymentDataFromJson(String str) =>
    PaymentData.fromJson(json.decode(str));

String paymentDataToJson(PaymentData data) => json.encode(data.toJson());

class PaymentData {
  PaymentData({
    this.success,
    this.msg,
    this.result,
  });

  bool? success;
  String? msg;
  Result? result;

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        success: json["success"],
        msg: json["msg"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "result": result?.toJson(),
      };
}

class Result {
  Result({
    this.id,
    this.totalPrice,
    this.expDate,
    this.status,
    this.foreignId,
  });

  String? id;
  String? totalPrice;
  DateTime? expDate;
  bool? status;
  String? foreignId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        totalPrice: json["totalPrice"],
        expDate: DateTime.parse(json["expDate"]),
        status: json["status"],
        foreignId: json["foreignId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalPrice": totalPrice,
        "expDate": expDate?.toIso8601String(),
        "status": status,
        "foreignId": foreignId,
      };
}
