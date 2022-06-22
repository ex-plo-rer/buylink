// To parse this JSON data, do
//
//     final autoCompleteModel = autoCompleteModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AutoCompleteModel autoCompleteModelFromJson(String str) =>
    AutoCompleteModel.fromJson(json.decode(str));

String autoCompleteModelToJson(AutoCompleteModel data) =>
    json.encode(data.toJson());

class AutoCompleteModel {
  AutoCompleteModel({
    required this.term,
    required this.result,
    required this.recentSearches,
  });

  String term;
  List<String> result;
  List<String> recentSearches;

  factory AutoCompleteModel.fromJson(Map<String, dynamic> json) =>
      AutoCompleteModel(
        term: json["term"],
        result: List<String>.from(json["result"].map((x) => x)),
        recentSearches:
            List<String>.from(json["recent_searches"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "term": term,
        "result": List<dynamic>.from(result.map((x) => x)),
        "recent_searches": List<dynamic>.from(recentSearches.map((x) => x)),
      };
}
