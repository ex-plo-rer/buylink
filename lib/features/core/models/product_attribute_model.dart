// To parse this JSON data, do
//
//     final productAttrModel = productAttrModelFromJson(jsonString);

import 'dart:convert';

ProductAttrModel productAttrModelFromJson(String str) => ProductAttrModel.fromJson(json.decode(str));

String productAttrModelToJson(ProductAttrModel data) => json.encode(data.toJson());

class ProductAttrModel {
  ProductAttrModel({
    required this.brand,
    required this.color,
    required this.age,
    required this.weight,
    required this.size,
    required this.model,
    required this.material,
    required this.care,
  });

  String brand;
  String color;
  String age;
  String weight;
  String size;
  String model;
  String material;
  String care;

  factory ProductAttrModel.fromJson(Map<String, dynamic> json) => ProductAttrModel(
    brand: json["brand"],
    color: json["color"],
    age: json["age"],
    weight: json["weight"],
    size: json["size"],
    model: json["model"],
    material: json["material"],
    care: json["care"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "color": color,
    "age": age,
    "weight": weight,
    "size": size,
    "model": model,
    "material": material,
    "care": care,
  };
}
