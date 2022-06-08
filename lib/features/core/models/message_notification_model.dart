// To parse this JSON data, do
//
//     final messageNotificationModel = messageNotificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageNotificationModel messageNotificationModelFromJson(String str) =>
    MessageNotificationModel.fromJson(json.decode(str));

String messageNotificationModelToJson(MessageNotificationModel data) =>
    json.encode(data.toJson());

class MessageNotificationModel {
  MessageNotificationModel({
    required this.name,
    required this.type,
    required this.image,
    required this.unread,
    required this.msg,
    required this.time,
  });

  String name;
  String type;
  String image;
  int unread;
  String msg;
  String time;

  factory MessageNotificationModel.fromJson(Map<String, dynamic> json) =>
      MessageNotificationModel(
        name: json["name"],
        type: json["type"],
        image: json["image"],
        unread: json["unread"],
        msg: json["msg"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "image": image,
        "unread": unread,
        "msg": msg,
        "time": time,
      };
}
