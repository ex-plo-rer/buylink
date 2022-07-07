// To parse this JSON data, do
//
//     final weeklyDataModel = weeklyDataModelFromJson(jsonString);

import 'dart:convert';

WeeklyDataModel weeklyDataModelFromJson(String str) =>
    WeeklyDataModel.fromJson(json.decode(str));

String weeklyDataModelToJson(WeeklyDataModel data) =>
    json.encode(data.toJson());

class WeeklyDataModel {
  WeeklyDataModel({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  List<Prdct> sunday;
  List<Prdct> monday;
  List<Prdct> tuesday;
  List<Prdct> wednesday;
  List<Prdct> thursday;
  List<Prdct> friday;
  List<Prdct> saturday;

  factory WeeklyDataModel.fromJson(Map<String, dynamic> json) =>
      WeeklyDataModel(
        sunday: List<Prdct>.from(json["sunday"].map((x) => Prdct.fromJson(x))),
        monday: List<Prdct>.from(json["monday"].map((x) => Prdct.fromJson(x))),
        tuesday:
            List<Prdct>.from(json["tuesday"].map((x) => Prdct.fromJson(x))),
        wednesday:
            List<Prdct>.from(json["wednesday"].map((x) => Prdct.fromJson(x))),
        thursday:
            List<Prdct>.from(json["thursday"].map((x) => Prdct.fromJson(x))),
        friday: List<Prdct>.from(json["friday"].map((x) => Prdct.fromJson(x))),
        saturday:
            List<Prdct>.from(json["saturday"].map((x) => Prdct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sunday": List<Prdct>.from(sunday.map((x) => x.toJson())),
        "monday": List<Prdct>.from(monday.map((x) => x.toJson())),
        "tuesday": List<Prdct>.from(tuesday.map((x) => x.toJson())),
        "wednesday": List<Prdct>.from(wednesday.map((x) => x.toJson())),
        "thursday": List<Prdct>.from(thursday.map((x) => x.toJson())),
        "friday": List<Prdct>.from(friday.map((x) => x.toJson())),
        "saturday": List<Prdct>.from(saturday.map((x) => x.toJson())),
      };
}

class Prdct {
  Prdct({
    required this.name,
    required this.image,
    required this.searches,
  });

  String name;
  String image;
  String searches;

  factory Prdct.fromJson(Map<String, dynamic> json) => Prdct(
        name: json["name"],
        image: json["image"],
        searches: json["searches"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "searches": searches,
      };
}
