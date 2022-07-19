// To parse this JSON products, do
//
//     final mostSearchedModel = mostSearchedModelFromJson(jsonString);

import 'dart:convert';

import 'most_searched_model.dart';

MostSearchedModel mostSearchedModelFromJson(String str) =>
    MostSearchedModel.fromJson(json.decode(str));

String mostSearchedModelToJson(MostSearchedModel products) =>
    json.encode(products.toJson());

class MostSearchedModel {
  MostSearchedModel({
    required this.products,
    required this.storeProductCount,
    required this.storeProductsSaved,
    required this.storeGrade,
    required this.unread,
  });

  List<MostSearchedProductModel> products;
  int storeProductCount;
  int storeProductsSaved;
  double storeGrade;
  bool unread;

  factory MostSearchedModel.fromJson(Map<String, dynamic> json) =>
      MostSearchedModel(
        products: List<MostSearchedProductModel>.from(
            json["data"].map((x) => MostSearchedProductModel.fromJson(x))),
        storeProductCount: json["store_product_count"],
        storeProductsSaved: json["store_products_saved"],
        storeGrade: json["store_grade"].toDouble(),
        unread: json["unread"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(products.map((x) => x.toJson())),
        "store_product_count": storeProductCount,
        "store_products_saved": storeProductsSaved,
        "store_grade": storeGrade,
        "unread": unread,
      };
}
