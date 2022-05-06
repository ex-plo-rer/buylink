// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
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

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
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
