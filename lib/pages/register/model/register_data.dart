// To parse this JSON data, do
//
//     final registerData = registerDataFromJson(jsonString);

import 'dart:convert';

RegisterData registerDataFromJson(String str) =>
    RegisterData.fromJson(json.decode(str));

String registerDataToJson(RegisterData data) => json.encode(data.toJson());

class RegisterData {
  RegisterData({
    this.success,
    this.user,
    this.message,
    this.userId,
  });

  bool? success;
  User? user;
  String? message;
  String? userId;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        success: json["success"],
        user: User.fromJson(json["user"]),
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
        "message": message,
        "user_id": userId,
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      };
}
