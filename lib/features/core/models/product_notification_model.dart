import 'dart:convert';

import 'package:buy_link/features/core/models/product_model.dart';

ProductNotificationModel productNotificationFromJson(String str) =>
    ProductNotificationModel.fromJson(json.decode(str));

String productNotificationToJson(ProductNotificationModel data) =>
    json.encode(data);

class ProductNotificationModel {
  ProductNotificationModel({
    required this.id,
    required this.product,
    required this.image,
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.store,
  });

  int id;
  String product;
  String image;
  double lat;
  double lon;
  DateTime dateTime;
  Store store;

  factory ProductNotificationModel.fromJson(Map<String, dynamic> json) =>
      ProductNotificationModel(
        id: json["id"],
        product: json["product"],
        image: json["image"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        dateTime: DateTime.parse(json["date-time"]),
        store: Store.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "image": image,
        "lat": lat,
        "lon": lon,
        "date-time": dateTime.toIso8601String(),
        "store": store.toJson(),
      };
}
