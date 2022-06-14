// // To parse this JSON data, do
// //
// //     final savedSessionModel = savedSessionModelFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// SavedSessionModel savedSessionModelFromJson(String str) =>
//     SavedSessionModel.fromJson(json.decode(str));
//
// String savedSessionModelToJson(SavedSessionModel data) =>
//     json.encode(data.toJson());
//
// class SavedSessionModel {
//   SavedSessionModel({
//    required this.name,
//    required this.image,
//    required this.chatId,
//    required this.msg,
//    required this.time,
//     //required this.timeStamp,
//    required this.unreadCount,
//   });
//
//   String name;
//   String? image;
//   String chatId;
//   String msg;
//   String time;
//   int? unreadCount;
//
//   // DateTime timeStamp;
//
//   factory SavedSessionModel.fromJson(Map<String, dynamic> json) =>
//       SavedSessionModel(
//         name: json["name"],
//         image: json["image"],
//         chatId: json["chat_id"],
//         msg: json["msg"],
//         time: json["time"],
//         // timeStamp: json["timeStamp"],
//         unreadCount: json["unread_count"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "image": image,
//         "chat_id": chatId,
//         "msg": msg,
//         "time": time,
//         // "timeStamp": timeStamp,
//         "unread_count": unreadCount,
//       };
// }
//
//

// To parse this JSON data, do
//
//     final savedSessionModel = savedSessionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SavedSessionModel savedSessionModelFromJson(String str) =>
    SavedSessionModel.fromJson(json.decode(str));

String savedSessionModelToJson(SavedSessionModel data) =>
    json.encode(data.toJson());

class SavedSessionModel {
  SavedSessionModel({
    required this.userId,
    required this.storeId,
    required this.name,
    required this.chatId,
    required this.image,
    required this.msg,
    required this.time,
    required this.parsedTime,
    this.unreadCount = 0,
  });

  int userId;
  int storeId;
  String name;
  String chatId;
  String? image;
  String msg;
  DateTime time;
  String parsedTime;
  int unreadCount;

  factory SavedSessionModel.fromJson(Map<String, dynamic> json) =>
      SavedSessionModel(
        userId: json["user_id"],
        storeId: json["store_id"],
        name: json["name"],
        chatId: json["chat_id"],
        image: json["image"],
        msg: json["msg"],
        time: DateTime.parse(json["time"]),
        parsedTime: json["parsed_time"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "store_id": storeId,
        "name": name,
        "chat_id": chatId,
        "image": image,
        "msg": msg,
        "time": time.toIso8601String(),
        "parsed_time": parsedTime,
      };
}
