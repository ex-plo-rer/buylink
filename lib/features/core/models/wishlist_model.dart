import 'dart:convert';

WishListModel wishlistModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishlistModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lon,
    required this.lat,
    required this.price,
    required this.oldPrice,
    required this.store,
  });

  int id;
  String name;
  List<String> image;
  double lon;
  double lat;
  int price;
  int oldPrice;
  Store store;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    id: json["id"],
    name: json["name"],
    image: List<String>.from(json["image"].map((x) => x)),
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
    price: json["price"],
    oldPrice: json["old_price"],
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
    "store": store.toJson(),
  };
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.location,
  });

  int id;
  String name;
  String location;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
  };
}
