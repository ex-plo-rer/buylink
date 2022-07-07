// To parse this JSON data, do
//
//     final analyticsModel = analyticsModelFromJson(jsonString);

import 'dart:convert';

AnalyticsModel analyticsModelFromJson(String str) =>
    AnalyticsModel.fromJson(json.decode(str));

String analyticsModelToJson(AnalyticsModel data) => json.encode(data.toJson());

class AnalyticsModel {
  AnalyticsModel({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.type,
    required this.total,
  });

  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  String type;
  int total;

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) => AnalyticsModel(
        sunday: json["sunday"],
        monday: json["monday"],
        tuesday: json["tuesday"],
        wednesday: json["wednesday"],
        thursday: json["thursday"],
        friday: json["friday"],
        saturday: json["saturday"],
        type: json["type"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "sunday": sunday,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "type": type,
        "total": total,
      };
}
