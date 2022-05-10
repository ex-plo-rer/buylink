import 'dart:convert';

StoreDetailsModel storeDetailsModelFromJson(String str) =>
    StoreDetailsModel.fromJson(json.decode(str));

String storeDetailsModelToJson(StoreDetailsModel data) => json.encode(data.toJson());

class StoreDetailsModel {
  StoreDetailsModel({
    required this.id,
    required this.name,
    required this.background,
    required this.logo,
    required this.star,
    required this.about,
    required this.address,
    required this.telephone,
    required this.email,
  });

  int id;
  String name;
  String background;
  String logo;
  double star;
  String about;
  String address;
  String telephone;
  String email;

  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) => StoreDetailsModel(
      id: json["id"],
      name: json["name"],
      background: json ["background"],
      logo: json ["logo"],
      star: json["star"],
      about: json ["about"],
      address: json ["address"],
      telephone: json ["telephone"],
      email: json ["email"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "background": background,
    "logo": logo,
    "star": star,
    "about": about,
    "address": address,
    "telephone": telephone,
    "email": email
  };
}
