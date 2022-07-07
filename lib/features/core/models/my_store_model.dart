// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

MyStoreModel productModelFromJson(String str) =>
    MyStoreModel.fromJson(json.decode(str));

String productModelToJson(MyStoreModel data) => json.encode(data.toJson());

class MyStoreModel {
  MyStoreModel({
    // required this.id,
    required this.star,
    required this.name,
    required this.image,
  });

  // int id;
  int star;
  String name;
  String image;

  factory MyStoreModel.fromJson(Map<String, dynamic> json) => MyStoreModel(
        // id: json["id"],
        star: json["star"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "star": star,
        "name": name,
        "image": image,
      };
}
