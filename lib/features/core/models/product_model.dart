// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lon,
    required this.lat,
    required this.price,
    required this.oldPrice,
    required this.isFav,
    required this.store,
    // required this.category,
  });

  int id;
  String name;
  List<String> image;
  double lon;
  double lat;
  int price;
  int oldPrice;
  bool isFav;
  Store store;
  // String category;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: List<String>.from(json["image"].map((x) => x)),
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
        price: json["price"],
        oldPrice: json["old_price"],
        isFav: json["is_fav"],
        store: Store.fromJson(json["store"]),
        // category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": List<dynamic>.from(image.map((x) => x)),
        "lon": lon,
        "lat": lat,
        "price": price,
        "old_price": oldPrice,
        "is_fav": isFav,
        "store": store.toJson(),
        // "category": category,
      };
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.location,
    required this.lon,
    required this.lat,
    required this.star,
    required this.logo,
  });

  int id;
  String name;
  String location;
  double lon;
  double lat;
  int star;
  String logo;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
        star: json["star"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "lon": lon,
        "lat": lat,
        "star": star,
        "logo": logo,
      };
}
