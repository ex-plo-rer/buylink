// To parse this JSON data, do
//
//     final checkMsgModel = checkMsgModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckMsgModel checkMsgModelFromJson(String str) =>
    CheckMsgModel.fromJson(json.decode(str));

String checkMsgModelToJson(CheckMsgModel data) => json.encode(data.toJson());

class CheckMsgModel {
  CheckMsgModel({
    required this.unread,
    required this.storeUnread,
  });

  bool unread;
  bool storeUnread;

  factory CheckMsgModel.fromJson(Map<String, dynamic> json) => CheckMsgModel(
        unread: json["unread"],
        storeUnread: json["store_unread"],
      );

  Map<String, dynamic> toJson() => {
        "unread": unread,
        "store_unread": storeUnread,
      };
}
