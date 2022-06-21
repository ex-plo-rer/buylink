// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'package:buy_link/features/core/models/product_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    required this.result,
    required this.searchTerm,
    required this.range,
  });

  List<ProductModel> result;
  String searchTerm;
  int range;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        result: List<ProductModel>.from(
            json["result"].map((x) => ProductModel.fromJson(x))),
        searchTerm: json["search_term"],
        range: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "search_term": searchTerm,
        "range": range,
      };
}
