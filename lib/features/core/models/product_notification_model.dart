import 'dart:convert';

ProductNotificationModel productNotificationFromJson(String str) =>
    ProductNotificationModel.fromJson(json.decode(str));

String productNotiificationToJson(ProductNotificationModel data) => json.encode(data.toJson());

class ProductNotificationModel {
  ProductNotificationModel({
    required this.id,
    required this.product,
    required this.image,
    required this.lat,
    required this.lon,
    required this.date_time

  });

  int id;
  String product;
  String image;
  double lat;
  double lon;
  String date_time;

  factory ProductNotificationModel.fromJson(Map<String, dynamic> json) => ProductNotificationModel(
    id: json["id"],
    product: json["product"],
    image: json ["image"],
    lat: json ["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    date_time: json ["date_time"]

  );

  Map<String, dynamic> toJson() => {
    "is": id,
    "product": product,
    "image": image,
    "lat": lat,
    "lon": lon,
    "date_time": date_time

  };
}