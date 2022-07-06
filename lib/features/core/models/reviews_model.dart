// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

ReviewsModel reviewsModelFromJson(String str) =>
    ReviewsModel.fromJson(json.decode(str));

String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  ReviewsModel({
    required this.id,
    required this.name,
    required this.title,
    required this.body,
    required this.star,
    required this.time,
  });

  int id;
  dynamic name;
  String title;
  String body;
  int star;
  String time;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        body: json["body"],
        star: json["star"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "body": body,
        "star": star,
        "time": time,
      };
}
