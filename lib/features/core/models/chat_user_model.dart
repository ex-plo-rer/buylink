// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

ChatUserModel userModelFromJson(String str) =>
    ChatUserModel.fromJson(json.decode(str));

String userModelToJson(ChatUserModel data) => json.encode(data.toJson());

class ChatUserModel {
  ChatUserModel({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
