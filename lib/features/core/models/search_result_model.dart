import 'dart:convert';

LoadResultsModel loadResultsFromJson(String str) =>
    LoadResultsModel.fromJson(json.decode(str));

String loadResultsToJson(LoadResultsModel data) => json.encode(data.toJson());

class LoadResultsModel {
  LoadResultsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lon,
    required this.lat,
    required this.price,
    required this.old_price,
    required this.store

  });

  int id;
  String name;
  List <String> image;
  double lon;
  double lat;
  int  price;
  int old_price;
  StoreResults store;

  factory LoadResultsModel.fromJson(Map<String, dynamic> json) => LoadResultsModel(
    id: json["id"],
    name: json["name"],
    image: json ["image"],
    lon: json ["lon"],
    lat: json["lat"],
    price: json ["price"],
    old_price: json["old_price"],
    store: json ["store"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "lon": lon,
    "lat": lat,
    "price": price,
    "old_price": old_price,
    "store": store


  };
}

class StoreResults {
  StoreResults({
    required this.id,
    required this.name,
    required this.location,
  });

  int id;
  String name;
  String? location;


  factory StoreResults.fromJson(Map<String, dynamic> json) => StoreResults(
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
