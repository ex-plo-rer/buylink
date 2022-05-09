// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

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
    // required this.descr,
    required this.store,
  });

  int id;
  String name;
  List<String> image;
  double lon;
  double lat;
  int price;
  int oldPrice;
  // String descr;
  Store store;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: List<String>.from(json["image"].map((x) => x)),
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
        price: json["price"],
        oldPrice: json["old_price"],
        // descr: json["descr"],
        store: Store.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": List<dynamic>.from(image.map((x) => x)),
        "lon": lon,
        "lat": lat,
        "price": price,
        "old_price": oldPrice,
        // "descr": descr,
        "store": store.toJson(),
      };
}

class Store {
  Store({
    required this.id,
    required this.name,
    // required this.image,
    required this.location,
    // required this.star,
    // required this.lon,
    // required this.lat,
  });

  int id;
  String name;
  // String image;
  String location;
  // int star;
  // double lon;
  // double lat;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        // image: json["image"],
        location: json["location"],
        // star: json["star"],
        // lon: json["lon"].toDouble(),
        // lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "image": image,
        "location": location,
        // "star": star,
        // "lon": lon,
        // "lat": lat,
      };
}
