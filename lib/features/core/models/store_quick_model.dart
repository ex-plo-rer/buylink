// To parse this JSON data, do
//
//     final storeQuickModel = storeQuickModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StoreQuickModel storeQuickModelFromJson(String str) =>
    StoreQuickModel.fromJson(json.decode(str));

String storeQuickModelToJson(StoreQuickModel data) =>
    json.encode(data.toJson());

class StoreQuickModel {
  StoreQuickModel({
    required this.name,
    required this.background,
    required this.logo,
    required this.star,
    required this.about,
    required this.address,
    required this.telephone,
    required this.email,
    required this.lon,
    required this.lat,
  });

  String name;
  String background;
  String logo;
  int star;
  String about;
  String address;
  String telephone;
  String email;
  double lon;
  double lat;

  factory StoreQuickModel.fromJson(Map<String, dynamic> json) =>
      StoreQuickModel(
        name: json["name"],
        background: json["background"],
        logo: json["logo"],
        star: json["star"],
        about: json["about"],
        address: json["address"],
        telephone: json["telephone"],
        email: json["email"],
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "background": background,
        "logo": logo,
        "star": star,
        "about": about,
        "address": address,
        "telephone": telephone,
        "email": email,
        "lon": lon,
        "lat": lat,
      };
}
