// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyStoreModel productModelFromJson(String str) =>
    MyStoreModel.fromJson(json.decode(str));

String productModelToJson(MyStoreModel data) => json.encode(data.toJson());

class MyStoreModel {
  MyStoreModel({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory MyStoreModel.fromJson(Map<String, dynamic> json) => MyStoreModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
