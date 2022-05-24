// To parse this JSON data, do
//
//     final mostSearchedProductModel = mostSearchedProductModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MostSearchedProductModel mostSearchedProductModelFromJson(String str) => MostSearchedProductModel.fromJson(json.decode(str));

String mostSearchedProductModelToJson(MostSearchedProductModel data) => json.encode(data.toJson());

class MostSearchedProductModel {
  MostSearchedProductModel({
    required this.name,
    required this.image,
    required this.searches,
    required this.star,
  });

  String name;
  String image;
  int searches;
  int star;

  factory MostSearchedProductModel.fromJson(Map<String, dynamic> json) => MostSearchedProductModel(
    name: json["name"],
    image: json["image"],
    searches: json["searches"],
    star: json["star"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "searches": searches,
    "star": star,
  };
}
