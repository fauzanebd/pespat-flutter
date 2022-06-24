// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

List<Place> placeListFromJson(String str) =>
    List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

String placeToJson(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  Place({
    this.id,
    this.photo,
    this.quota,
    this.price,
    this.contact,
    this.address,
    this.details,
    this.name,
  });

  String? id;
  String? photo;
  int? quota;
  int? price;
  String? contact;
  String? address;
  String? details;
  String? name;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        photo: json["photo"],
        quota: json["quota"] == null ? null : json["quota"],
        price: json["price"],
        contact: json["contact"],
        address: json["address"],
        details: json["details"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "quota": quota == null ? null : quota,
        "price": price,
        "contact": contact,
        "address": address,
        "details": details,
        "name": name,
      };
}
