// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.userData,
    this.success,
    this.token,
    this.message,
    this.userId,
  });

  UserData? userData;
  bool? success;
  String? token;
  String? message;
  String? userId;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        userData: UserData.fromJson(json["userData"]),
        success: json["success"],
        token: json["token"],
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "userData": userData?.toJson(),
        "success": success,
        "token": token,
        "message": message,
        "user_id": userId,
      };
}

class UserData {
  UserData({
    this.lastName,
    this.email,
    this.firstName,
    this.password,
  });

  String? lastName;
  String? email;
  String? firstName;
  String? password;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        lastName: json["lastName"],
        email: json["email"],
        firstName: json["firstName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "lastName": lastName,
        "email": email,
        "firstName": firstName,
        "password": password,
      };
}
