// To parse this JSON data, do
//
//     final reviewStatsModel = reviewStatsModelFromJson(jsonString);

import 'dart:convert';

ReviewStatsModel reviewStatsModelFromJson(String str) =>
    ReviewStatsModel.fromJson(json.decode(str));

String reviewStatsModelToJson(ReviewStatsModel data) =>
    json.encode(data.toJson());

class ReviewStatsModel {
  ReviewStatsModel({
    required this.id,
    required this.total,
    required this.the5Star,
    required this.the4Star,
    required this.the3Star,
    required this.the2Star,
    required this.the1Star,
  });

  int id;
  int total;
  int the5Star;
  int the4Star;
  int the3Star;
  int the2Star;
  int the1Star;

  factory ReviewStatsModel.fromJson(Map<String, dynamic> json) =>
      ReviewStatsModel(
        id: json["id"],
        total: json["total"],
        the5Star: json["5_star"],
        the4Star: json["4_star"],
        the3Star: json["3_star"],
        the2Star: json["2_star"],
        the1Star: json["1_star"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "5_star": the5Star,
        "4_star": the4Star,
        "3_star": the3Star,
        "2_star": the2Star,
        "1_star": the1Star,
      };
}
