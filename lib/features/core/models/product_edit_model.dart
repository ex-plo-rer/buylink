// To parse this JSON data, do
//
//     final productEditModel = productEditModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductEditModel productEditModelFromJson(String str) =>
    ProductEditModel.fromJson(json.decode(str));

String productEditModelToJson(ProductEditModel data) =>
    json.encode(data.toJson());

class ProductEditModel {
  ProductEditModel({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.brand,
    required this.colors,
    required this.category,
    required this.ageMin,
    required this.ageMax,
    required this.weightMin,
    required this.weightMax,
    required this.size,
    required this.model,
    required this.material,
    required this.care,
  });

  int id;
  String name;
  List<String> images;
  int price;
  int oldPrice;
  String description;
  String brand;
  String colors;
  String category;
  int ageMin;
  int ageMax;
  int weightMin;
  int weightMax;
  String size;
  String model;
  String material;
  String care;

  factory ProductEditModel.fromJson(Map<String, dynamic> json) =>
      ProductEditModel(
        id: json["id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        oldPrice: json["old_price"],
        description: json["description"],
        brand: json["brand"],
        colors: json["colors"],
        category: json["category"],
        ageMin: json["age_min"],
        ageMax: json["age_max"],
        weightMin: json["w_min"],
        weightMax: json["w_max"],
        size: json["size"],
        model: json["model"],
        material: json["material"],
        care: json["care"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "old_price": oldPrice,
        "description": description,
        "brand": brand,
        "colors": colors,
        "category": category,
        "age_min": ageMin,
        "age_max": ageMax,
        "w_min": weightMin,
        "w_max": weightMax,
        "size": size,
        "model": model,
        "material": material,
        "care": care,
      };
}
